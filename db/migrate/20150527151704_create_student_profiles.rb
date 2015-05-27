class CreateStudentProfiles < ActiveRecord::Migration
  def change
    create_table :student_profiles do |t|
      t.integer :user_id

      t.string :first_name
      t.string :last_name
      t.string :gender
      t.string :high_school
      t.string :graduation_year

      t.timestamps null: false
    end
  end
end
