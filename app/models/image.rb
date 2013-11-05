class Image < ActiveRecord::Base
  attr_accessible :uri, :uploader
  validates :uri, :presence => true

  belongs_to :pet

  has_many(
    :captions,
    :foreign_key => :image_id,
    :primary_key => :id,
    :class_name => "Caption"
  )

end
