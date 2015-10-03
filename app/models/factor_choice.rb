class FactorChoice < ActiveRecord::Base
  belongs_to :factor

  validates :factor, presence: true
  validates :name, presence: :true
  validates :value, presence: true
end
