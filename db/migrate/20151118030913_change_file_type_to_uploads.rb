class ChangeFileTypeToUploads < ActiveRecord::Migration
  def change
    change_column :uploads, :file_type_id,  :string, :default => ""
    rename_column :uploads, :file_type_id, :upload_type
  end
end
