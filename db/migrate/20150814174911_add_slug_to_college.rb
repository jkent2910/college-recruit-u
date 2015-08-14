class AddSlugToCollege < ActiveRecord::Migration
  def change
    add_column :colleges, :slug, :string
    add_index :colleges, :slug, unique: true
  end
end
