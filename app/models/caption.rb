class Caption < ActiveRecord::Base
  attr_accessible :image, :top_text, :bottom_text, :captioner

  validate :top_and_bottom_captions_not_both_blank

  belongs_to(
    :image,
    :foreign_key => :image_id,
    :primary_key => :id,
    :class_name => "Image"
  )

  belongs_to(
    :captioner,
    :foreign_key => :captioner_id,
    :primary_key => :id,
    :class_name => "User"
  )

  private

    def top_and_bottom_captions_not_both_blank
      if :top_text.blank? && :bottom_text.blank?
        errors[:top_text] << "Both text fields cannot be blank."
      end
    end
end
