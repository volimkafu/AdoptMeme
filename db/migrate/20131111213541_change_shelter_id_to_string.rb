class ChangeShelterIdToString < ActiveRecord::Migration
  def change
    change_column :pets, :shelter_id, :string
  end
end
