require 'rmagick'
require 'AdoptMemeAwsHelper'

class Caption < ActiveRecord::Base
  include AdoptMemeAwsHelper
  include Magick

  validates :captioner, :image, :presence => true
  belongs_to :image
  belongs_to :captioner

  belongs_to(
    :captioner,
    :foreign_key => :captioner_id,
    :primary_key => :id,
    :class_name => "User"
  )

  def source
    @image_src ||= RestClient.get(self.image.amazon_aws_url)
    @source ||= Image.read(@image_src).first
  end

  def fontsize(message)
    self.source.columns / message.length - 5
  end

  def draw_top_text(message)
    Draw.new.annotate(@source,0,0,0,10, message) {
        self.font_family = 'Impact'
        self.fill = 'white'
        self.stroke = 'black'
        self.stroke_width = 3
        #self.pointsize = 32
        self.pointsize = fontsize(source, message)
        self.font_weight = Magick::BoldWeight
        self.gravity = Magick::NorthGravity
    }
  end

end
