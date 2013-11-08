class Image < ActiveRecord::Base
  include AdoptMemeAwsHelper

  validates :petfinder_url, :presence => true

  after_create :push_image_to_aws
  # after_destroy :delete_pets_without_images

  belongs_to :pet
  has_many :captions, :inverse_of => :image
  has_many :captioned_images, :through => :caption, :source => :captioned_images

  private
    def delete_pets_without_images
      if pet.images.count.zero?
        pet.destroy
      end
    end

end
