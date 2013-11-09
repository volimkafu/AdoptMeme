class CreateCaptionedImages < ActiveRecord::Migration
  def change
    create_table :captioned_images do |t|
      t.integer :caption_id
      t.string :aws_url
      t.timestamps
    end
  end
end
