class PagesController < ApplicationController

  def home
    if current_user
      @student_profile = current_user.student_profile

      @high_school = params[:high_school]
      if @high_school.blank? || @high_school == '*'
        @student_profiles = StudentProfile.where(incognito: false).order(created_at: :desc).limit(15)
      else
        @student_profiles = StudentProfile.where(incognito: false, high_school: @high_school).order(created_at: :desc)
      end

      if sort_order == "pop"
        @colleges = College.order(college_student_statuses_count: :desc).limit(20)
      elsif sort_order == "recent"
        @colleges = College.order(created_at: :desc).limit(20)
      elsif sort_order == "alpha"
        @colleges = College.order(:name)
      end
    else
      redirect_to root_path
    end
  end

  private

  def sort_order
    %w[alpha pop recent].include?(params[:order]) ? params[:order] : "alpha"
  end
end
