class Image < ActiveRecord::Base
  validates :petfinder_url, :pet_id, :presence => true

  after_create :push_image_to_aws
  handle_asynchronously :create_aws_object

  belongs_to :pet
  has_many :captions, :inverse_of => :image

  def create_aws_object(name, content)
    # Creating objects: http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/S3/S3Object.html
    s3 = AWS::S3.new
    bucket = s3.bucket[:adoptmeme]
    bucket.objects[name].write(content)
  end

  def push_image_to_aws
    image = RestClient.get(self.petfinder_url)
    resource_name = self.aws_resource_name
    self.amazon_aws_url = "http://s3.amazonaws.com/adoptmeme/" + resource_name
    self.save
    create_aws_object(resource_name, image)
  end

  def aws_id
    # Sequential ids are disfavored on S3 for performance reasons.
    # So we reverse the id.
    self.id.to_s.reverse
  end

  def aws_resource_name
    "#{self.aws_id}.jpg"
  end

end
