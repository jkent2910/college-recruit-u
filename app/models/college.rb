class College < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates_presence_of :name, :college_type, :city, :state, :region

  has_many :college_student_statuses

  has_many :student_profiles, through: :college_student_statuses

  has_many :photos, dependent: :destroy

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment :logo,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { less_than: 2.megabytes }

  searchable_by :name

  def fans
    college_student_statuses.just_a_fan.map(&:student_profile)
  end

  def considering
    college_student_statuses.considering.map(&:student_profile)
  end

  def applying
    college_student_statuses.applying.map(&:student_profile)
  end

  def enrolling
    college_student_statuses.enrolling.map(&:student_profile)
  end

  def total_students_count
    college_student_statuses_count
  end

end
