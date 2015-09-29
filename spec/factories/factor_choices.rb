FactoryGirl.define do
  sequence :choice_name do |n|
    "Choice #{n}"
  end

  factory :factor_choice do |f|
    association :factor
    f.choice_name
    value 1
  end
end
