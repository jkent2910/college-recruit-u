FactoryGirl.define do
  sequence :choice_name do |n|
    "Choice #{n}"
  end

  factory :factor_choice do
    association :factor
    name { generate(:choice_name) }
    value 1
  end
end
