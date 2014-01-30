class Image < ActiveRecord::Base
  include Storable

  validates :petfinder_url, :presence => true

  after_create :push_petfinder_image_to_aws
  # after_destroy :delete_pets_without_images

  belongs_to :pet
  has_many :captions, :inverse_of => :image

  def aws_resource_name
    "#{self.aws_id}.jpg"
  end

  def push_petfinder_image_to_aws
    begin
      sleep 0.1 # slow down requests to petfinder.
      raise 'Invalid image url' if self.petfinder_url.include?('///')
      image = RestClient.get(self.petfinder_url)
      create_aws_object(image)
    rescue
      puts "There was a problem with Image #{self.id}"
      self.delete
    end
  end

  private
    def delete_pets_without_images
      if pet.images.count.zero?
        pet.destroy
      end
    end

end
