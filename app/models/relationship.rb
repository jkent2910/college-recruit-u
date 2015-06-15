class Relationship < ActiveRecord::Base
  belongs_to :fan, class_name: "StudentProfile"
  belongs_to :fan_of, class_name: "StudentProfile"
end
