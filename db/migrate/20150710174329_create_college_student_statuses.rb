class CreateCollegeStudentStatuses < ActiveRecord::Migration
  def change
    create_table :college_student_statuses do |t|
      t.belongs_to :college, index: true
      t.belongs_to :student_profile, index: true
      t.string :status_name

      t.timestamps null: false
    end
  end
end
