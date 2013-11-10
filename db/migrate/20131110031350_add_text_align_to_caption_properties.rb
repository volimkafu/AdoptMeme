class AddTextAlignToCaptionProperties < ActiveRecord::Migration
  def change
    add_column :captions, :text_align, :string, :default => "center"
  end
end
