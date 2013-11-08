class Image < ActiveRecord::Base
  validates :petfinder_url, :presence => true

  after_create :push_image_to_aws
  # after_destroy :delete_pets_without_images

  belongs_to :pet
  has_many :captions, :inverse_of => :image
  has_many :captioned_images, :through => :caption, :source => :captioned_images

  def create_aws_object(name, content)
    # Creating objects: http://docs.aws.amazon.com/AWSRubySDK/latest/AWS/S3/S3Object.html
    s3 = AWS::S3.new
    bucket = s3.buckets[:adoptmeme]
    bucket.objects[name].write(content)
  end
  # handle_asynchronously :create_aws_object

  def push_image_to_aws
    resource_name = self.aws_resource_name
    self.amazon_aws_url = "http://s3.amazonaws.com/adoptmeme/" + resource_name
    self.save

    begin
      sleep 0.25 # slow down requests to petfinder.
      image = RestClient.get(self.petfinder_url)
      create_aws_object(resource_name, image)
    rescue
      puts "There was a problem with Image #{self.id}"
      self.delete
    end
  end

  def aws_id
    # Sequential ids are disfavored on S3 for performance reasons.
    # So we reverse the id.
    self.id.to_s.reverse
  end

  def aws_resource_name
    "#{self.aws_id}.jpg"
  end

  private
    def delete_pets_without_images
      if pet.images.count.zero?
        pet.destroy
      end
    end

end
