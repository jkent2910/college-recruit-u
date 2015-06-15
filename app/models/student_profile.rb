class StudentProfile < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :gender, :high_school, :graduation_year
  belongs_to :student, class_name: "User", foreign_key: "user_id"

  has_many :fan_relationships, class_name: "Relationship", foreign_key: "fan_of_id"
  has_many :fan_of_relationships, class_name: "Relationship", foreign_key: "fan_id"

  has_many :fans, through: :fan_relationships
  has_many :fan_of, through: :fan_of_relationships

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def fan_of?(other)
    self.fan_of.include? other
  end

  def become_fan_of(other)
    self.fan_of_relationships.create!(fan: self, fan_of: other) unless fan_of? other
  end

  def stop_being_a_fan_of(other)
    self.fan_of.delete(other)
  end
end
