FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@school.k12.ia.us"
  end

  factory :user do |u|
    u.email
    u.password 'password'
    u.password_confirmation 'password'
  end

  factory :sarah, :parent => :user do |s|
    s.email 'sarah@school.k12.ia.us'
    s.sign_in_count 2
  end
end
