class CollegeStudentStatus < ActiveRecord::Base

  VALID_STATUSES = ['Just a Fan', 'Considering', 'Applying', 'Enrolling']

  belongs_to :student_profile
  belongs_to :college

end
