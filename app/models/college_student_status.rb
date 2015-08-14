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

  scope :just_a_fan,  -> { where(status_name: 'Just a Fan').includes(:student_profile) }
  scope :considering, -> { where(status_name: 'Considering').includes(:student_profile) }
  scope :applying,    -> { where(status_name: 'Applying').includes(:student_profile) }
  scope :enrolling,   -> { where(status_name: 'Enrolling').includes(:student_profile) }

end
