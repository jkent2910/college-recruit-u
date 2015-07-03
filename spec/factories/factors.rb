FactoryGirl.define do
  sequence :name do |n|
    "Factor #{n}"
  end

  factory :factor do |f|
    f.name
  end
end
