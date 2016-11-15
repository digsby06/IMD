class AddAmbientContentToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :ambient_content, :boolean, :default => false
    add_column :uploads, :name, :string
  end
end
