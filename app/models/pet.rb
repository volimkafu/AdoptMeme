class Pet < ActiveRecord::Base
  validates :name, :petfinder_id, :shelter_id, :presence => true
  validates :petfinder_id, :uniqueness => true

  has_many :images, :dependent => :destroy
  has_many :captioned_images, :through => :images, :source => :captions

  @@petfinder_api_key = ENV["PETFINDER_API_KEY"]
  @@petfinder_secret_key = ENV["PETFINDER_API_SECRET"]

  def self.fetch_random
    petfinder_url = Addressable::URI.new(
      scheme: "http",
      host: "api.petfinder.com",
      path: "pet.find",
      query_values: {
        :key => @@petfinder_api_key,
        :format => :json,
        :output => :full,
        :animal => :cat,
        :status => :A, # A = Adoptable
        :location => 94103,
        :count => 50  # number of records to return
      }
    ).to_s

    payload = RestClient.get(petfinder_url)
    Pet.parse_pets_from_petfinder_json(JSON.parse(payload))
  end

  def self.remove_expired_pets
    available_pets = Pet.where(:pet_available => true)
    results = []
    available_pets.each do |pet|
      payload = RestClient.get(pet.url_to_check_availability)
      payload = JSON.parse(payload)
      pet.update_availability(!payload["petfinder"]["pet"]["status"].empty?)
    end
  end

  private
    def self.parse_pets_from_petfinder_json(payload)
      payload["petfinder"]["pets"]["pet"].each do |pet_record|
        pet = Pet.new
        pet.name = pet_record["name"]["$t"].split("_").first.gsub(/[0-9]/, '')
        pet.sex = pet_record["sex"]["$t"]
        pet.petfinder_id = pet_record["id"]["$t"]
        pet.shelter_id = pet_record["shelterId"]["$t"]
        pet.description = pet_record["description"]["$t"]

        # Also store references to full-resolution pet photos
        pet_record["media"]["photos"]["photo"].each do |photo|
          if photo["@size"] == "x"
            image = pet.images.new
            image.petfinder_url = photo["$t"]
          end
        end

        pet.save unless pet.images.empty?
      end
    end

    def url_to_check_availability
      Addressable::URI.new(
        scheme: "http",
        host: "api.petfinder.com",
        path: "pet.get",
        query_values: {
          :key => @@petfinder_api_key,
          :format => :json,
          :id => petfinder_id
        }
      ).to_s
    end

    def update_availability(availability)
      if availability != pet_available
        self.pet_available = availability
        save
      end
    end
end