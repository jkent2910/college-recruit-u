FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@school.k12.ia.us"
  end

  factory :user do |u|
    u.email
    u.password 'password'
    u.password_confirmation 'password'
    after(:create) { |user| user.confirm! }
  end

  factory :sarah, :parent => :user do |s|
    s.email 'sarah@school.k12.ia.us'
  end
end
