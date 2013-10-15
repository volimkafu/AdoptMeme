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
