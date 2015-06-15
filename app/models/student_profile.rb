class StudentProfile < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :gender, :high_school, :graduation_year
  belongs_to :student, class_name: "User", foreign_key: "user_id"

  has_many :fan_relationships, class_name: "Relationship", foreign_key: "fan_of_id"
  has_many :fan_of_relationships, class_name: "Relationship", foreign_key: "fan_id"

  has_many :fans, through: :fan_relationships
  has_many :fan_of, through: :fan_of_relationships
end
