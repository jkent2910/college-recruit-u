class CollegesController < ApplicationController
  before_action :authenticate_user!

  def index
    @colleges = College.all
  end

  def show
    @college = College.find(params[:id])
    @student_profile = current_user.student_profile
    @college_status = @student_profile.try(:college_status, @college)
  end

  def student_status
    college = College.find(params[:id])
    student_profile = StudentProfile.find(params[:student_profile_id])
    status = params[:college_student_status]

    if current_user != student_profile.student
      redirect_to college_path(college), notice: "You are not allowed to perform that action."
      return
    end

    if student_profile.college_student_statuses.where(status_name: "Enrolling").count == 1 
      redirect_to college_path(college), notice: "You can only enroll at one school."
      return
    end

    if status.blank?
      student_profile.college_status(college).destroy
      flash[:notice] = "You removed #{college.name} from your profile"
    else
      student_profile.add_or_update_college_status(college, status)
      flash[:notice] = "You are now #{status_message(status)} #{college.name}"
    end

    redirect_to college_path(college)
  end

  private

  def status_message(status)
    status + CollegeStudentStatus::STATUS_MESSAGE_SUFFIX[status]
  end
end
