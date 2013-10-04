class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :url, :presence => true

end
