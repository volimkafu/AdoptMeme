class User < ActiveRecord::Base
  # attr_accessible :title, :body
  [:email, :username].each do |attribute|
      validates attribute :presence => true, :uniquesness => true
  end


end
