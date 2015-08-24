require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  include Devise::TestHelpers

  before do
    @sarah = FactoryGirl.create(:sarah)
    @student_profile = FactoryGirl.create(:student_profile, student: @sarah)
    @college = FactoryGirl.create(:college)
    sign_in @sarah
  end

  describe "GET #index" do
    it "assigns all colleges as @colleges" do
      get :index
      expect(assigns(:colleges)).to eq([@college])
    end
  end

  describe "GET #show" do
    it "assigns the requested college as @college" do
      get :show, {id: @college.to_param}
      expect(assigns(:college)).to eq(@college)
    end

    it "assigns the current user's student profile as @student_profile" do
      get :show, {id: @college.to_param}
      expect(assigns(:student_profile)).to eq(@student_profile)
    end

    it "assigns college status as @college_status" do
      status = @student_profile.add_or_update_college_status(@college, 'Just a Fan')
      get :show, {id: @college.to_param}
      expect(assigns(:college_status)).to eq(status)
    end
  end

  describe "POST #student_status" do
    context "when the specified student profile belongs to the current user" do
      before do
        post :student_status, {id: @college.to_param, student_profile_id: @student_profile.to_param, college_student_status: 'Just a Fan'}
      end

      it "adds or updates the college student status" do
        expect(@student_profile.college_status(@college).status_name).to eq('Just a Fan')
      end

      it "displays an appropriate message" do
        expect(flash[:notice]).to match /just a fan/i
      end

      it "redirects to the college show page" do
        expect(response).to redirect_to(college_path(@college))
      end
    end

    context "remove college" do
      before do
        @student_profile.add_or_update_college_status(@college, 'Considering')
      end

      it "confirm test is set up correctly" do
        expect(@student_profile.college_status(@college).status_name).to eq('Considering')
      end

      it "college is removed if status is blank" do
        post :student_status, {id: @college.to_param, student_profile_id: @student_profile.to_param, college_student_status: ''}
        expect(@student_profile.college_status(@college)).to be_nil
      end

      it "displays an appropriate message" do
        post :student_status, {id: @college.to_param, student_profile_id: @student_profile.to_param, college_student_status: ''}
        expect(flash[:notice]).to match /you removed/i
      end
    end

    context "only allow one college to be enrolled status" do
      before do 
        @other_college = FactoryGirl.create(:college)
        @student_profile.add_or_update_college_status(@college, 'Enrolling')
      end

      it "confirm test is set up correctly" do
        expect(@student_profile.college_status(@college).status_name).to eq('Enrolling')
      end

      it "does not allow student to add more than one college with enrolling status" do
        post :student_status, {id: @other_college.to_param, student_profile_id: @student_profile.to_param, college_student_status: 'Enrolling'}
        expect(flash[:notice]).to match /you can only/i
      end
    end

    context "when the specified student profile does not belong to the current user" do
      before do
        other_profile = FactoryGirl.create(:student_profile)
        post :student_status, {id: @college.to_param, student_profile_id: other_profile.to_param, college_student_status: 'Just a Fan'}
      end

      it "does not add or update the college student status" do
        expect(@student_profile.college_status(@college)).to be_nil
      end

      it "displays an appropriate message" do
        expect(flash[:notice]).to match /you are not allowed/i
      end

      it "redirects to the college show page" do
        expect(response).to redirect_to(college_path(@college))
      end
    end
  end
end
