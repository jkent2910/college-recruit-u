require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  include Devise::TestHelpers

  context "when user is signed in" do
    before do
      @sarah = FactoryGirl.create(:sarah)
      @student_profile = FactoryGirl.create(:student_profile, student: @sarah)
      sign_in @sarah
    end

    it "assigns the user' student profile as @student_profile" do
      get :home
      expect(assigns(:student_profile)).to eq @student_profile
    end

    it "assigns all student profiles as @student_profiles" do
      get :home
      expect(assigns(:student_profiles)).to eq [@student_profile]
    end

    it "assigns all colleges as @colleges" do
      college = FactoryGirl.create(:college)
      get :home
      expect(assigns(:colleges)).to eq [college]
    end
  end

  context "when user is not signed in" do
    it "redirects to the root path" do
      get :home
      expect(response).to redirect_to(root_path)
    end
  end
end
