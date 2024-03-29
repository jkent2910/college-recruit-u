class StudentProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student_profile, only: [:show, :edit, :update, :destroy, :become_a_fan, :stop_being_a_fan]
  before_action :check_for_existing_profile, only: [:new, :create]
  before_action :ensure_student_ownership, only: [:edit, :update, :destroy]

  # GET /student_profiles
  # GET /student_profiles.json
  def index
    @high_school = params[:high_school]
    if @high_school.blank? || @high_school == '*'
      @student_profiles = StudentProfile.where(incognito: false).order("created_at DESC")
    else
      @student_profiles = StudentProfile.where(incognito: false, high_school: @high_school).order("created_at DESC")
    end

    if current_user.student_profile == nil 
      redirect_to new_student_profile_path, notice: "You must create a student profile first"
    end

  end

  # GET /student_profiles/1
  # GET /student_profiles/1.json
  def show
    @student_profiles = StudentProfile.where(incognito: false)
  end

  # GET /student_profiles/new
  def new
    @student_profile = StudentProfile.new
  end

  # GET /student_profiles/1/edit
  def edit
  end

  # POST /student_profiles
  # POST /student_profiles.json
  def create
    @student_profile = StudentProfile.new(student_profile_params)
    @student_profile.student = current_user

    respond_to do |format|
      if @student_profile.save
        format.html { redirect_to @student_profile, notice: 'Great! Your profile is created.' }
        format.json { render :show, status: :created, location: @student_profile }
      else
        format.html { render :new }
        format.json { render json: @student_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student_profiles/1
  # PATCH/PUT /student_profiles/1.json
  def update
    respond_to do |format|
      @student_profile.interests = student_profile_params[:interests]
      @student_profile.majors = student_profile_params[:majors]
      if @student_profile.update(student_profile_params)
        format.html { redirect_to @student_profile, notice: 'Student profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_profile }
      else
        format.html { render :edit }
        format.json { render json: @student_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student_profiles/1
  # DELETE /student_profiles/1.json
  def destroy
    @student_profile.destroy
    respond_to do |format|
      format.html { redirect_to colleges_path, notice: 'Student profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def become_a_fan
    other_profile = StudentProfile.friendly.find params.require(:other_profile_id)
    @student_profile.become_fan_of(other_profile)
    redirect_to :student_profiles
  end

  def stop_being_a_fan
    other_profile = StudentProfile.friendly.find params.require(:other_profile_id)
    @student_profile.stop_being_a_fan_of(other_profile)
    redirect_to :student_profiles
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student_profile
    @student_profile = StudentProfile.includes(:factor_ratings, :factors).friendly.find(params[:id])
  end

  def check_for_existing_profile
    if current_user.student_profile
      redirect_to current_user.student_profile, notice: "You have already created a profile."
    end
  end

  def ensure_student_ownership
    if current_user != StudentProfile.friendly.find(params[:id]).student
      redirect_to student_profiles_path, notice: "You are not allowed to perform that action."
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_profile_params
    params.require(:student_profile).permit(:first_name, :last_name, :gender, :high_school, :graduation_year, :photo, :cell_number, interests: [], majors: [], factor_ratings_attributes: [:id, :factor_id, :factor_choice_id])
  end
end
