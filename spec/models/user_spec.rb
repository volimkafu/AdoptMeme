require 'spec_helper'

describe User do

  subject(:user) { User.create(email: "jennifer@gmail.com", username: "jen") }

  it { should be_valid }
  it { should respond_to(:email) }
  it { should respond_to(:username) }
  it { should respond_to(:images) }
  it { should respond_to(:captions) }
  
  it "should not expose the password hash" do
    user.should_not respond_to(:password_digest)
    user.should_not respond_to(:password) 
  end
  
  it "should allow the password to be changed" do
    user.should respond_to(:password=) 
  end

  describe "validations" do
    context "should not allow invalid zipcodes to be saved" do
      it "doesn't allow zipcodes under 5 digits" do
        user.zipcode = 9000 
        user.should_not be_valid
      end

      it "doesn't allow zipcodes with more than 5 digits" do
        user.zipcode = 100000
        user.should_not be_valid
      end

      it "doesn't allow non-numeric zipcodes" do
        user.zipcode = "hello"
        user.should_not be_valid
      end

      it "doesn't allow non-integer zipcodes" do
        user.zipcode = "1234.5"
        user.should_not be_valid
      end
    end

    it "should not allow users to be created using emails already in use." do
      user2 = User.new(email: user.email, username: "Sarah") 
      user2.should_not be_valid
    end

    it "should not allow user creation with duplicate user names." do
      user2 = User.new(email: "example@gmail.com", username: user.username)
      user2.should_not be_valid
    end
  end


end
