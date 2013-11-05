require 'addressable/uri'

class Pet < ActiveRecord::Base

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
      path: "pet.getRandom",
      query_values: {
        :key => @@petfinder_api_key,
        :format => :json,
        :output => :full,
        :animal => :cat,
        :zipcode => 94103
      }
    ).to_s

    payload = RestClient.get(petfinder_url)
    parsePets(JSON.parse(payload))
  end

  def parsePets
    # ["petfinder"]["pet"][0]["media"]["photos"]["photo"][0].values.include?("x")
  end
end