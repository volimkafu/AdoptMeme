class DropTableCaptionedImages < ActiveRecord::Migration
  def change
    drop_table :captioned_images
  end
end
