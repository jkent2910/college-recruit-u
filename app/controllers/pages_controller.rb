class PagesController < ApplicationController

  def home
    if current_user

      @student_profile = current_user.student_profile

      @student_profiles = StudentProfile.all

      @colleges = College.all

    else
      redirect_to root_path
    end
  end

end
