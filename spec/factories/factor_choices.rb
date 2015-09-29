FactoryGirl.define do
  sequence :choice do |n|
    "Choice #{n}"
  end

  factory :factor_choice do |f|
    association :factor
    f.choice
  end
end
