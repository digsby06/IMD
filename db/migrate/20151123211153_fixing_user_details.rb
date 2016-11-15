class FixingUserDetails < ActiveRecord::Migration
  def change
    remove_column :users, :name
    remove_column :users, :lastname
  end
end
