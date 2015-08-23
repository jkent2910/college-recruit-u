class WelcomeController < ApplicationController
  skip_before_action :create_student_profile_on_first_signin, only: :index

  def index
  end

  private

  def create_student_profile_on_first_signin
    if user_signed_in? && current_user.sign_in_count < 2
      redirect_to :new_student_profile
    elsif user_signed_in? && current_user.sign_in_count >= 2
      redirect_to home_path
    else 
      redirect_to root_path
    end
  end
end
