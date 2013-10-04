class Caption < ActiveRecord::Base
  # attr_accessible :title, :body
  validate :top_and_bottom_captions_not_both_blank



  private

    def top_and_bottom_captions_not_both_blank
      if @top_text.blank? && @bottom_text.blank?
        errors[:top_text] << "Both text fields cannot be blank."
      end
    end
end
