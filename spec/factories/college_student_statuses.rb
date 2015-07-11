FactoryGirl.define do
  sequence :status_name do |n|
    "Status #{n}"
  end

  factory :college_student_status do |f|
    f.status_name
  end
end