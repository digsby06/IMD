class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :file
      t.integer :user_id
      t.integer :file_type_id

      t.timestamps
    end
  end
end
