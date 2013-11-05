class AddSourceToImages < ActiveRecord::Migration
  def change
    remove_column :images, :uri
    remove_column :images, :uploader_id
    add_column :images, :petfinder_url, :string
    add_column :images, :amazon_aws_url, :string
    add_column :images, :pet_id, :integer
    add_index :images, :pet_id
  end
end
