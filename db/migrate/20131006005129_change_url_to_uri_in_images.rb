class ChangeUrlToUriInImages < ActiveRecord::Migration
  def change
    remove_column :images, :url
    add_column :images, :uri, :string
  end
end
