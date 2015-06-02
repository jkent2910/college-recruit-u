class User < ActiveRecord::Base
  # Others available are: :timeoutable and :omniauthable

  devise :database_authenticatable, :confirmable, :lockable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]

  has_one :student_profile

  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  		if user.provider == "twitter"
  			user.email = "#{self.name}_email@example.com"
  		else
  			user.email = auth.info.email
  		end
  		user.provider = auth.provider
  		user.uid = auth.uid
  		user.password = Devise.friendly_token[0,20]
  		user.skip_confirmation!
  	end
  end
end

