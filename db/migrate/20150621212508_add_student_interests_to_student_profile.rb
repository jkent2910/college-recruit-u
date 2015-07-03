class AddStudentInterestsToStudentProfile < ActiveRecord::Migration
  def change
    add_column :student_profiles, :interests, :text
  end
end
