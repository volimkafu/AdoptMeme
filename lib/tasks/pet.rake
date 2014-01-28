namespace :pet do
	desc "Pull limited development data down from Petfinder API"
	task :pullrand => :environment do
		Pet.fetch_random
	end

	desc "Clear out local and remote stores of pet information"
	task :clear => :environment do
		Pet.delete_all
		Image.delete_all
		Caption.delete_all
		i = Image.new
		i.empty_bucket
	end

	desc "Update pet availability with calls to the Petfinder API"
	task :remove_expired => :environment do
		Pet.remove_expired
	end

	desc "Refresh Pet database, removing expired and replacing with new"
	task :refresh => :environment do
		Pet.remove_expired_pets
		Pet.fetch_random
	end
end
