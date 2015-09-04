class User < ActiveRecord::Base
  # Others available are: :confirmable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :lockable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable

  has_one :student_profile
end
