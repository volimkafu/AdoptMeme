class Pet < ActiveRecord::Base
  validates :name, :petfinder_id, :shelter_id, :presence => true

  has_many :images, :inverse_of => :pet

  @@petfinder_api_key = ENV["PETFINDER_API_KEY"]
  @@petfinder_secret_key = ENV["PETFINDER_API_SECRET"]

  def self.petfinder_api_key
    @@petfinder_api_key
  end

  def self.petfinder_secret_key
    @@petfinder_secret_key
  end

  def fetchRandom
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
        :count => 100  # number of records to return
      }
    ).to_s

    payload = RestClient.get(petfinder_url)
    Pet.parse_pets(JSON.parse(payload))
  end

  def self.parse_pets(payload)
    payload["petfinder"]["pet"].each do |pet_record|
      pet = Pet.new
      pet.name = pet_record["name"]["$t"]
      pet.sex = pet_record["sex"]["$t"]
      pet.petfinder_id = pet_record["id"]["$t"]
      pet.shelter_id = pet_record["shelterId"]["$t"]
      pet.description = pet_record["description"]["$t"]
      pet.save!


      # Also store references to full-resolution pet photos
      pet_record["media"]["photos"]["photo"].each do |photo|
        if photo["@size"] == "x"
          petfinder_image_path = photo["$t"]
          pet.images << Image.create(petfinder_url: petfinder_image_path)
        end
      end

    end
  end
end