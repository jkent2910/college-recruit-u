FactoryGirl.define do
  factory :photo do
    name "campus.jpg"
    photo ""

    association :college
  end
end
