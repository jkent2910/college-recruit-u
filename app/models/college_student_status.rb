class CollegeStudentStatus < ActiveRecord::Base

  VALID_STATUSES = ['Just a Fan', 'Considering', 'Applying', 'Enrolling']

  validates :status_name, inclusion: { in: VALID_STATUSES }

  belongs_to :student_profile
  belongs_to :college
end
