class StudentProfile < ActiveRecord::Base
  extend StudentProfilesHelper

  VALID_GRADUATION_YEARS = ['2016', '2017', '2018', '2019']

  validates_presence_of :first_name, :last_name, :gender, :high_school, :graduation_year
  validates_inclusion_of :graduation_year, in: VALID_GRADUATION_YEARS

  validates_each :interests do |record, attr, value|
    value.each do |interest|
      record.errors.add(attr, "contains an invalid interest") unless student_interests.include?(interest)
    end
  end

  belongs_to :student, class_name: "User", foreign_key: "user_id"

  has_many :fan_relationships, class_name: "Relationship", foreign_key: "fan_of_id"
  has_many :fan_of_relationships, class_name: "Relationship", foreign_key: "fan_id"

  has_many :fans, through: :fan_relationships, dependent: :destroy
  has_many :fan_of, through: :fan_of_relationships, dependent: :destroy

  has_many :factor_ratings, dependent: :delete_all
  has_many :factors, through: :factor_ratings

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment :photo,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { less_than: 2.megabytes }

  serialize :interests, Array

  accepts_nested_attributes_for :factor_ratings

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
