require 'spec_helper'

describe User do

  subject(:user) { User.create(email: "jennifer@gmail.com", username: "jen", zipcode: 32444 ) }

  it { should be_valid }
  it { should respond_to(:email) }
  it { should respond_to(:username) }
  it { should respond_to(:images) }
  it { should respond_to(:captions) }

  describe "validations" do
    it "should not allow invalid zipcodes to be saved" do
      user2 = User.new( email: "hello@gmail.com", username: "susan", zipcode: 4355432 )
      user2.should_not be_valid
    end

    it "should not allow users to be created using emails already in use." do
      user2 = User.new( email: "jennifer@gmail.com", username: "Sarah", zipcode: 32444 ) 
      user2.should_not be_valid
    end

    it "should not allow user creation with duplicate user names." do
      user2 = User.new( email: "jennifer@gmail.com", username: "jen", zipcode: 32444 ) 
      user2.should_not be_valid
    end
  end


end
