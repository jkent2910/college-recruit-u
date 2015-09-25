class PagesController < ApplicationController

  def home
    if current_user
      @student_profile = current_user.student_profile

      @student_profiles = StudentProfile.where(incognito: false).order(created_at: :desc)

      if sort_order == "pop"
        @new_colleges = College.order(created_at: :desc).limit(20).sort_by { |college| -college.college_student_statuses_count }
      else
        @new_colleges = College.order(created_at: :desc).limit(20).sort_by { |college| college.name }
      end
    else
      redirect_to root_path
    end
  end

  private

  def sort_order
    %w[alpha pop].include?(params[:order]) ? params[:order] : "alpha"
  end
end
