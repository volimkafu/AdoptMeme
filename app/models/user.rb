class User < ActiveRecord::Base
  # attr_accessible :title, :body
  [:email, :username].each do |attribute|
      validates attribute :presence => true, :uniquesness => true
  end

  has_many(
    :images
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
