class CollegeStudentStatus < ActiveRecord::Base

  VALID_STATUSES = ['Just a Fan', 'Considering', 'Applying', 'Enrolling']

  #TODO: Is there a better way to do this?
  STATUS_MESSAGE_SUFFIX = {
    'Just a Fan' => ' of',
    'Considering' => '',
    'Applying' => ' to',
    'Enrolling' => ' in'
  }

  validates :status_name, inclusion: { in: VALID_STATUSES }

  belongs_to :student_profile
  belongs_to :college

  scope :just_a_fan, -> { where(status_name: 'Just a Fan') }
  scope :considering, -> { where(status_name: 'Considering') }
  scope :applying, -> { where(status_name: 'Applying') }
  scope :enrolling, -> { where(status_name: 'Enrolling') }

end
