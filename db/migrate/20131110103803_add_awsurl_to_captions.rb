class AddAwsurlToCaptions < ActiveRecord::Migration
  def change
    add_column :captions, :amazon_aws_url, :string
  end
end
