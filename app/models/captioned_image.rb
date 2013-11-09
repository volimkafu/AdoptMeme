class CaptionedImage < ActiveRecord::Base
  include AdoptMemeAwsHelper
  belongs_to :caption
  validates :caption_id, :presence => true
end
