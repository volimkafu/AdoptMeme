class User < ActiveRecord::Base
  attr_accessible :email, :username, :zipcode, :fname, :lname

  [:email, :username].each do |attribute|
      validates attribute, :presence => true, :uniqueness => true
  end
    
  validates :zipcode, :format => { :with => /^\d{5}$/ }
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  
  def self.find_by_token(token)
    User.where(:session_token => token).first
  end
  
  def self.find_by_credentials(username_or_email, password)
    user = User.where(:email => username_or_email).first
    return user if (!!user && user.is_password?(password))
    user = User.where(:username => username_or_email).first
    return user if (!!user && user.is_password?(password))  
    nil
  end
  
  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64(32)
  end
  
  has_many(
    :images,
    :foreign_key => :uploader_id,
    :primary_key => :id,
    :class_name => "Image"
  )

  has_many(
    :captions,
    :foreign_key => :captioner_id,
    :primary_key => :id,
    :class_name => "Caption"
  )



end
