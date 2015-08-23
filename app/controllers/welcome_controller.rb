class WelcomeController < ApplicationController
  before_action :create_student_profile_on_first_signin

  def index
  end

  private

  def create_student_profile_on_first_signin
    if user_signed_in? && current_user.sign_in_count < 2
      redirect_to :new_student_profile
    else
      redirect_to home_path
    end
  end
end
