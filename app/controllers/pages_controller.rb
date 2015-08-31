class PagesController < ApplicationController

  def home
    if current_user

      @student_profile = current_user.student_profile

      @student_profiles = StudentProfile.where(incognito: false).order("created_at DESC")

      @colleges = College.order('name ASC')
    else
      redirect_to root_path
    end
  end

end
