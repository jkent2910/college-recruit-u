class College < ActiveRecord::Base
  
  validates_presence_of :name, :type, :city, :state, :region

  has_many :college_student_statuses

  has_many :student_profiles, through: :college_student_statuses
  
end
