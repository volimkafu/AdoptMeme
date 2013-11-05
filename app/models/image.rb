class Image < ActiveRecord::Base
  attr_accessible :uri, :uploader

  validates :petfinder_url, :pet_id, :presence => true

  belongs_to :pet, :inverse_of => :images
  after_create :push_image_to_aws

  has_many(
    :captions,
    :foreign_key => :image_id,
    :primary_key => :id,
    :class_name => "Caption"
  )

  def create_aws_object(name, content)
    # Creating objects: http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/S3/S3Object.html
    s3 = AWS::S3.new
    bucket = s3.bucket[:adoptmeme]
    bucket.objects[name].write(content)
  end

  def push_image_to_aws
    image = RestClient.get(self.petfinder_url)
    resource_name = "#{self.id}.jpg"
    create_aws_object(resource_name, image)
    self.amazon_aws_url = "http://adoptmeme.s3.amazonaws.com/" + resource_name
    self.save
  end

end
