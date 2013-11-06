class AddAttrsToPets < ActiveRecord::Migration
  def change
      add_column :pets, :name, :string
      add_column :pets, :sex, :string
      add_column :pets, :petfinder_id, :integer
      add_column :pets, :shelter_id, :integer
      add_column :pets, :description, :text
  end
end
