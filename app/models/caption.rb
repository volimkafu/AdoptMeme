class Caption < ActiveRecord::Base
  validates :captioner, :image, :presence => true

  belongs_to :image
  has_many :captioned_images, :inverse_of :caption

  belongs_to(
    :captioner,
    :foreign_key => :captioner_id,
    :primary_key => :id,
    :class_name => "User"
  )

end
