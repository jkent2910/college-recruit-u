class AddSlugToStudentProfile < ActiveRecord::Migration
  def change
    add_column :student_profiles, :slug, :string
    add_index :student_profiles, :slug, unique: true
  end
end
