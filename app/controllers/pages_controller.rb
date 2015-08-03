class PagesController < ApplicationController

  def home
    @student_profile = current_user.student_profile

    @student_profiles = StudentProfile.all

    @colleges = College.all
  end

end