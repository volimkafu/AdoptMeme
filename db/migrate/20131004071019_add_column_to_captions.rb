class AddColumnToCaptions < ActiveRecord::Migration
  def change
    add_column :captions, :image_id, :integer
  end
end
