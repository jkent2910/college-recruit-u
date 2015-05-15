class User < ActiveRecord::Base
  # Others available are: :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable
end
