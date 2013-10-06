class ChangeUserZipcodeDefault < ActiveRecord::Migration
  def change
    remove_column :users, :zipcode
    add_column :users, :zipcode, :string, :default => '00000' 
  end
end
