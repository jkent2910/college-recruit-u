class PagesController < ApplicationController

  def home
    if current_user

      @student_profile = current_user.student_profile

      @student_profiles = StudentProfile.where(incognito: false).order("created_at DESC")

      @colleges = College.order('name ASC')

      @new_colleges = College.order('created_at DESC').limit(20)
    else
      redirect_to root_path
    end
  end

end
