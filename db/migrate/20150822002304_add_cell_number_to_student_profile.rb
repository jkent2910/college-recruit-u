class AddCellNumberToStudentProfile < ActiveRecord::Migration
  def change
    add_column :student_profiles, :cell_number, :string
  end
end
