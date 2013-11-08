class CaptionedImage < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :caption
end
