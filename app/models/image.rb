require 'adopt_meme_aws_helper'

class Image < ActiveRecord::Base
  include AdoptMemeAwsHelper

  validates :petfinder_url, :presence => true

  after_create :push_petfinder_image_to_aws
  # after_destroy :delete_pets_without_images

  belongs_to :pet
  has_many :captions, :inverse_of => :image
  has_many :captioned_images, :through => :caption, :source => :captioned_images

  def push_petfinder_image_to_aws
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

  private
    def delete_pets_without_images
      if pet.images.count.zero?
        pet.destroy
      end
    end

end
