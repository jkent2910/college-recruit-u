class AddMajorsToStudentProfile < ActiveRecord::Migration
  def change
    add_column :student_profiles, :majors, :text
  end
end
