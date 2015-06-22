class AddStudentInterestsToStudentProfile < ActiveRecord::Migration
  def change
    add_column :student_profiles, :student_interests, :text
  end
end
