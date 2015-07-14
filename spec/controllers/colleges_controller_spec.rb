require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  include Devise::TestHelpers

  before do
    @sarah = FactoryGirl.create(:sarah)
    @student_profile = FactoryGirl.create(:student_profile, student: @sarah)
    sign_in @sarah
  end

  describe "GET #index" do
    it "assigns all colleges as @colleges" do
      college = FactoryGirl.create(:college)
      get :index
      expect(assigns(:colleges)).to eq([college])
    end
  end

  describe "GET #show" do
    before do
      @college = FactoryGirl.create(:college)
    end

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
end
