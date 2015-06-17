class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :fan_id
      t.integer :fan_of_id

      t.timestamps null: false
    end
  end
end
