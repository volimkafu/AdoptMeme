class CreateCaptions < ActiveRecord::Migration
  def change
    create_table :captions do |t|
      t.string :top_text
      t.string :bottom_text
      t.integer :captioner_id
      t.timestamps
    end
  end
end
