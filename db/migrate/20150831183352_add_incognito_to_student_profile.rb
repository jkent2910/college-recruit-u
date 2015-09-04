class AddIncognitoToStudentProfile < ActiveRecord::Migration
  def change
    add_column :student_profiles, :incognito, :boolean, default: false
  end
end
