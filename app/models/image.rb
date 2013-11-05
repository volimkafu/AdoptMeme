class Image < ActiveRecord::Base
  attr_accessible :uri, :uploader

  validates :petfinder_url, :pet_id, :presence => true

  belongs_to :pet, :inverse_of => :images

  has_many(
    :captions,
    :foreign_key => :image_id,
    :primary_key => :id,
    :class_name => "Caption"
  )

end
