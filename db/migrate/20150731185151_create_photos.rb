class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :college_id
      t.string :name
      t.attachment :photo

      t.timestamps null: false
    end
  end
end
