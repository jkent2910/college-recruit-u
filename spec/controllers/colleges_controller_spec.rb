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

    context "when enrolling in more than one college" do
      before do
        @enrolling_college1 = FactoryGirl.create(:college, name: "College 1")
        @enrolling_college2 = FactoryGirl.create(:college, name: "College 2")
        @student_profile.add_or_update_college_status(@enrolling_college1, 'Enrolling')
        @student_profile.add_or_update_college_status(@enrolling_college2, 'Enrolling')
      end

      it "allows the student to remove a college with an enrolling status" do
        expect(@student_profile.college_student_statuses.enrolling.count).to be 2
        post :student_status, {id: @enrolling_college1.to_param, student_profile_id: @student_profile.to_param, college_student_status: ''}
        expect(@student_profile.college_student_statuses.enrolling.count).to be 1
        expect(flash[:notice]).to match /you removed/i
      end

      it "allows the student to remove a college when enrolling in 3 colleges" do
        enrolling_college3 = FactoryGirl.create(:college, name: "College 3")
        @student_profile.add_or_update_college_status(enrolling_college3, 'Enrolling')
        expect(@student_profile.college_student_statuses.enrolling.count).to be 3
        post :student_status, {id: @enrolling_college1.to_param, student_profile_id: @student_profile.to_param, college_student_status: ''}
        expect(@student_profile.college_student_statuses.enrolling.count).to be 2
        expect(flash[:notice]).to match /you removed/i
      end
    end

    context "when enrolling in a college" do
      before do
        @other_college = FactoryGirl.create(:college)
        @student_profile.add_or_update_college_status(@college, 'Enrolling')
      end

      it "does not allow student to enroll in another college" do
        expect(@student_profile.college_student_statuses.enrolling.count).to be 1
        post :student_status, {id: @other_college.to_param, student_profile_id: @student_profile.to_param, college_student_status: 'Enrolling'}
        expect(@student_profile.college_student_statuses.enrolling.count).to be 1
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

  describe "POST #ask_question" do
    it "loads the specified college as @college" do
      post :ask_question, {id: @college.to_param, question: "my silly question"}
      expect(assigns[:college]).to eq @college
    end

    it "sends an email" do
      expect {
        post :ask_question, {id: @college.to_param, question: "my silly question"}
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "displays an appropriate message" do
      post :ask_question, {id: @college.to_param, question: "my silly question"}
      expect(flash[:notice]).to match /we'll be in touch/i
    end

    it "redirects to the college show page" do
      post :ask_question, {id: @college.to_param, question: "my silly question"}
      expect(response).to redirect_to(@college)
    end
  end

  describe "POST #request_college" do

    it "sends an email" do
      expect {
        post :request_college, {question: "Iowa State University"}
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "displays an appropriate message" do
      post :request_college, {id: @college.to_param, question: "Iowa State University"}
      expect(flash[:notice]).to match /we will get right on that/i
    end

    it "redirects to the college index page" do
      post :request_college, {question: "Iowa State University"}
      expect(response).to redirect_to(colleges_path)
    end
  end

  describe "POST #application_help" do
    it "loads the specified college as @college" do
      post :application_help, {id: @college.to_param, question: "please help me"}
      expect(assigns[:college]).to eq @college
    end

    it "sends an email" do
      expect {
        post :application_help, {id: @college.to_param, question: "please help me"}
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "displays an appropriate message" do
      post :application_help, {id: @college.to_param, question: "please help me"}
      expect(flash[:notice]).to match /we'll be in touch/i
    end

    it "redirects to the college show page" do
      post :application_help, {id: @college.to_param, question: "please help me"}
      expect(response).to redirect_to(@college)
    end
  end
end
