class User < ActiveRecord::Base
  attr_accessible :email, :username, :zipcode
  [:email, :username].each do |attribute|
      validates attribute, :presence => true, :uniqueness => true
  end

  has_many(
    :images,
    :foreign_key => :uploader_id,
    :primary_key => :id,
    :class_name => "Image"
  )

  has_many(
    :captions,
    :foreign_key => :captioner_id,
    :primary_key => :id,
    :class_name => "Caption"
  )


end
