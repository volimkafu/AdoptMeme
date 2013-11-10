require 'rmagick'
require 'adopt_meme_aws_helper'

class Caption < ActiveRecord::Base
  include AdoptMemeAwsHelper
  include Magick

  WATERMARK_FONT = '/Library/Fonts/Helvetica.ttf'
  MEME_FONT = '/Library/Fonts/Impact.ttf'

  validates :captioner, :image, :presence => true
  belongs_to :image
  belongs_to :captioner, :foreign_key => :captioner_id, :class_name => "User"
  after_save :create_captioned_image

  def aws_resource_name
    "caption/#{self.aws_id}.jpg"
  end

  def source
    @image_src ||= get_aws_object(self.image.aws_resource_name)
    @source ||= Image.from_blob(@image_src).first
  end

  def fontsize(msg)
    d = Draw.new
    pointsize = d.pointsize = 0
    until d.get_multiline_type_metrics(msg).width > self.source.columns
      pointsize += 10
      d.pointsize = pointsize
    end
    pointsize
  end

  def chars_per_line
    @max_chars ||= Math.floor(self.source.columns / 30)
  end

  def purpleize
    self.source.level_colors("#0A1226", "#D1D9FF", true)
  end

  def grayscale
    self.source.quantize(256, Magick::GRAYColorspace).contrast(true)
  end

  def set_meme_annotation_settings(draw)
    draw.font = MEME_FONT
    draw.fill = 'white'
    draw.stroke = 'black'
    draw.interline_spacing = -15
    draw.stroke_width = 2
    draw.font_weight = BolderWeight
  end

  def draw_top_text
    d = Draw.new
    set_meme_annotation_settings(d)
    d.pointsize = fontsize(self.top_text)
    d.gravity = NorthGravity
    d.annotate(self.source, 0, 0, 0, 0, self.top_text)
  end

  def draw_bottom_text
    d = Draw.new
    set_meme_annotation_settings(d)
    d.gravity = SouthGravity
    d.pointsize = fontsize(self.bottom_text)
    d.annotate(source, 0, 0, 0, 20, self.bottom_text)
  end

  def draw_watermark
    link = "AdoptMe.me/#{self.id}"
    Draw.new.annotate(self.source, 0,0,0,0, link) {
      self.gravity = SouthEastGravity
      self.font = WATERMARK_FONT
      self.font_weight = BoldWeight
      self.pointsize = 20
      self.fill = 'green'
      self.undercolor = 'yellow'
    }
  end

  def insert_newlines(message)
    words = message.split(' ')
    lines, current_line = [], []

    words.each do |word|
      test_line = (current_line + [word]).join(' ')
      if test_line.length < self.chars_per_line
        current_line << word
      else
        lines << current_line.join(' ')
        current_line = [word]
      end
    end

    lines << current_line.join(' ')
    lines.join('\n')
  end

  def create_captioned_image
    draw_top_text unless self.top_text.blank?
    draw_bottom_text unless self.bottom_text.blank?
    draw_watermark
    create_aws_object(aws_resource_name, source)
  end
end
