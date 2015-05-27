class StudentProfile < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :gender, :high_school, :graduation_year
  belongs_to :student, class_name: "User", foreign_key: "user_id"
end
