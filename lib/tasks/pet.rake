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
end
