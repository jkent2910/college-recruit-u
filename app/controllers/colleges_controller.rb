class CollegesController < ApplicationController
  before_action :authenticate_user!

  def index
    @colleges = College.all
  end

  def show
    @college = College.find(params[:id])
    student_profile = current_user.student_profile
    @college_status = student_profile.try(:college_status, @college)
  end
end
