class AddGroupToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :group_id, :integer
  end
end
