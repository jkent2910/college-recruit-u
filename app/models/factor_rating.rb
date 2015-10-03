class FactorRating < ActiveRecord::Base
  belongs_to :student_profile
  belongs_to :factor
  belongs_to :factor_choice

  validates :factor_choice_id, presence: true
end
