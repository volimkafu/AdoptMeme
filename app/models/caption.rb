require 'adopt_meme_aws_helper'

class Caption < ActiveRecord::Base
  attr_accessible :bottom_text,
                  :bottom_text_align,
                  :top_text,
                  :top_text_align,
                  :image_id,
                  :image,
                  :captioner_id

  include AdoptMemeAwsHelper
  include Magick

  WATERMARK_FONT = '/Library/Fonts/Helvetica.ttf'
  MEME_FONT = '/Library/Fonts/Impact.ttf'

  validates :image_id, :presence => true
  validates :top_text_align, :bottom_text_align, :inclusion => ["center", "left", "right"]

  belongs_to :image
  belongs_to :captioner, :foreign_key => :captioner_id, :class_name => "User"
  after_create :upcase_text, :create_captioned_image

  delegate :pet, :to => :image, :prefix => true

  def aws_resource_name
    "caption/#{self.aws_id}.jpg"
  end

  def upcase_text
    self.top_text = self.top_text.upcase
    self.bottom_text = self.bottom_text.upcase
  end

  protected
    def create_captioned_image
      draw_top_text unless self.top_text.blank?
      draw_bottom_text unless self.bottom_text.blank?
      draw_watermark
      create_aws_object(aws_resource_name, source.to_blob)
    end

    def source
      @image_src ||= get_aws_object(self.image.aws_resource_name)
      @source ||= Image.from_blob(@image_src).first
    end

    def fontsize(msg)
      d = Draw.new
      pointsize = d.pointsize = 0
      allowable_width = self.source.columns*0.90
      allowable_height = self.source.rows * 0.30
      until ((d.get_multiline_type_metrics(msg).width > allowable_width) ||
        (d.get_multiline_type_metrics(msg).height > allowable_height))
        pointsize += 10
        d.pointsize = pointsize
      end

      pointsize
    end

    def chars_per_line
      @max_chars ||= self.source.columns / 15
    end

    def purpleize
      self.source.level_colors("#0A1226", "#D1D9FF", true)
    end

    def grayscale
      self.source.quantize(256, GRAYColorspace).contrast(true)
    end

    def set_meme_annotation_settings(draw)
      draw.font = MEME_FONT
      draw.fill = 'white'
      draw.stroke = 'black'
      draw.interline_spacing = -5
      draw.stroke_width = 2
      draw.font_weight = BolderWeight
    end

    def draw_top_text
      d = Draw.new
      set_meme_annotation_settings(d)
      formatted_text = insert_newlines(self.top_text)
      d.pointsize = fontsize(formatted_text)

      case self.top_text_align
      when "center" then d.gravity = NorthGravity
      when "left" then d.gravity = NorthWestGravity
      when "right" then d.gravity = NorthEastGravity
      end

      d.annotate(self.source, 0, 0, 0, 0, formatted_text)
    end

    def draw_bottom_text
      d = Draw.new
      set_meme_annotation_settings(d)
      formatted_text = insert_newlines(self.bottom_text)
      d.pointsize = fontsize(formatted_text)

      case self.bottom_text_align
      when "center" then d.gravity = SouthGravity
      when "left" then d.gravity = SouthWestGravity
      when "right" then d.gravity = SouthEastGravity
      end

      d.annotate(source, 0, 0, 0, 20, formatted_text)
    end

    def draw_watermark
      link = "AdoptMe.me/#{self.id}"
      Draw.new.annotate(self.source, 0,0,0,0, link) {
        self.gravity = SouthEastGravity
        self.font = WATERMARK_FONT
        self.font_weight = BoldWeight
        self.pointsize = 20
        self.fill = '#EAFFFA'
        self.undercolor = '#E64F00'
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

end
