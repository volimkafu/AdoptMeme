class CreateCaptionedImages < ActiveRecord::Migration
  def change
    create_table :captioned_images do |t|

      t.timestamps
    end
  end
end
