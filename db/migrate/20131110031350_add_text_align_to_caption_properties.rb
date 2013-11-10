class AddTextAlignToCaptionProperties < ActiveRecord::Migration
  def change
    add_column :captions, :top_text_align, :string, :default => "center"
    add_column :captions, :bottom_text_align, :string, :default => "center"
  end
end
