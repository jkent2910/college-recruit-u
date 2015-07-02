class FactorRating < ActiveRecord::Base
  belongs_to :student_profile
  belongs_to :factor

  validates :importance, presence: true,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 5 }
end
