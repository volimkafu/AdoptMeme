require 'addressable/uri'

class Pet < ActiveRecord::Base

  has_many :images

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
      path: "pet.getPets",
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
    parsePets(JSON.parse(payload))
  end

  def parsePets
    # ["petfinder"]["pet"][0]["media"]["photos"]["photo"][0].values.include?("x")
  end
end