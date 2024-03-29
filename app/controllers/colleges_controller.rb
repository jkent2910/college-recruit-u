# coding: utf-8
class CollegesController < ApplicationController
  before_action :authenticate_user!

  def index
    if sort_order == "pop"
      @colleges = College.order(college_student_statuses_count: :desc).limit(20)
    elsif sort_order == "recent"
      @colleges = College.order(created_at: :desc).limit(20)
    elsif sort_order == "alpha"
      @colleges = College.order(:name)
    end
  end

  def show
    @college = College.friendly.find(params[:id])
    @student_profile = current_user.student_profile
    @college_status = @student_profile.try(:college_status, @college)
    @twitter_message = "I have #{@college.name} on my profile–where are you considering? Join for free"
  end

  def student_status
    college = College.friendly.find(params[:id])
    student_profile = StudentProfile.friendly.find(params[:student_profile_id])
    status = params[:college_student_status]

    if current_user != student_profile.student
      redirect_to college_path(college), notice: "You are not allowed to perform that action."
      return
    end

    if status.blank?
      student_profile.college_status(college).destroy
      flash[:notice] = "You removed #{college.name} from your profile"
    else
      if status == 'Enrolling' && student_profile.college_student_statuses.enrolling.any?
        flash[:notice] = "You can only enroll at one school."
      else
        student_profile.add_or_update_college_status(college, status)
        flash[:notice] = "You are now #{status_message(status)} #{college.name}"
      end
    end

    redirect_to college_path(college)
  end

  def ask_question
    @college = College.friendly.find(params[:id])
    student_profile = current_user.student_profile
    question = params[:question]
    UserMailer.ask_a_question(student_profile, @college, question).deliver_now
    flash[:notice] = "We'll be in touch soon!"
    redirect_to @college
  end

  def application_help
    @college = College.friendly.find(params[:id])
    student_profile = current_user.student_profile
    question = params[:question]
    UserMailer.application_help(student_profile, @college, question).deliver_now
    flash[:notice] = "We'll be in touch soon!"
    redirect_to @college
  end

  def request_college
    student_profile = current_user.student_profile
    question = params[:question]
    UserMailer.request_a_college(student_profile, question).deliver_now
    flash[:notice] = "We will get right on that!"
    redirect_to colleges_path
  end

  private

  def status_message(status)
    status + CollegeStudentStatus::STATUS_MESSAGE_SUFFIX[status]
  end

  def sort_order
    %w[alpha pop recent].include?(params[:order]) ? params[:order] : "alpha"
  end
end
