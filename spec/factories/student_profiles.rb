FactoryGirl.define do
  factory :student_profile do
    first_name "Sarah"
    last_name "Smith"
    gender "Female"
    high_school "Valley High School"
    graduation_year "2016"
    cell_number "319-521-8353"

    association :student, factory: :user
  end
end
