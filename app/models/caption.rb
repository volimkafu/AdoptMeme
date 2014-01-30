class Caption < ActiveRecord::Base
  attr_accessible :bottom_text,
                  :bottom_text_align,
                  :top_text,
                  :top_text_align,
                  :image_id,
                  :image,
                  :captioner_id

  include Storable

  validates :image_id, :presence => true

  belongs_to :image
  belongs_to :captioner, :foreign_key => :captioner_id, :class_name => "User"

  delegate :pet, :to => :image, :prefix => true

  def aws_resource_name
    "caption/#{self.aws_id}.png"
  end
end
