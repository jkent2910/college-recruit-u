class FactorChoice < ActiveRecord::Base
  belongs_to :factor

  validates :factor, presence: true
  validates :choice, presence: :true
end
