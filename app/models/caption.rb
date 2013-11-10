require 'rmagick'
require 'adopt_meme_aws_helper'

class Caption < ActiveRecord::Base
  include AdoptMemeAwsHelper
  include Magick

  validates :captioner, :image, :presence => true
  belongs_to :image
  belongs_to :captioner, :foreign_key => :captioner_id, :class_name => "User"

  MIN_POINTSIZE = 20

  def aws_resource_name
    "caption/#{self.aws_id}.jpg"
  end

  def source
    @image_src ||= get_aws_object(self.image.aws_resource_name)
    @source ||= Image.from_blob(@image_src).first
  end

  def fontsize(message)
    base_size = self.source.columns / message.length - 5
    return base_size if base_size > MIN_POINTSIZE
    MIN_POINTSIZE
  end

  def draw_top_text(message)
    Draw.new.annotate(@source, 0, 0, 0, 10, message) {
        self.font_family = 'Impact'
        self.fill = 'white'
        self.stroke = 'black'
        self.stroke_width = 3
        self.pointsize = fontsize(message)
        self.font_weight = BoldWeight
        self.gravity = NorthGravity
    }
  end

end
