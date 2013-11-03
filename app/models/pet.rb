class Pet < ActiveRecord::Base

  @@petfinder_api_key = ENV["PETFINDER_API_KEY"]
  @@petfinder_secret_key = ENV["PETFINDER_API_SECRET"]

  def self.petfinder_api_key
    @@petfinder_api_key
  end

  def self.petfinder_secret_key
    @@petfinder_secret_key
  end

end
