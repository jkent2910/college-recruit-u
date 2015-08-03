class College < ActiveRecord::Base

  validates_presence_of :name, :college_type, :city, :state, :region

  has_many :college_student_statuses

  has_many :student_profiles, through: :college_student_statuses

  has_many :photos, dependent: :destroy

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "missing.png"
  validates_attachment :logo,
                       content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
                       size: { less_than: 2.megabytes }

  searchable_by :name

end
