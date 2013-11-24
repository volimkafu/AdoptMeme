class PetAvailability < ActiveRecord::Migration
  def up
    add_column :pets, :pet_available, :boolean, :default => true
  end

  def down
    remove_column :pets, :pets_available
  end
end
