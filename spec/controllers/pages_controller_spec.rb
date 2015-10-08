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

    it "excludes incognito student profiles" do
      incognito_profile = FactoryGirl.create(:student_profile, incognito: true)
      get :home
      expect(assigns(:student_profiles)).not_to include(incognito_profile)
    end

    it "assigns new colleges as @colleges" do
      college = FactoryGirl.create(:college)
      get :home
      expect(assigns(:colleges)).to eq [college]
    end

    describe "sorting" do
      before do
        %w[ccc aaa bbb].each do |name|
          FactoryGirl.create(:college, name: name)
        end
      end

      it "orders colleges alphabetically by default" do
        get :home
        expect(assigns(:colleges).map(&:name)).to eql(%w[aaa bbb ccc])
      end

      it "orders colleges by popularity when requested" do
        {"ccc" => 3, "bbb" => 1}.each do |name, n|
          college = College.where(name: name).take
          n.times do
            sp = FactoryGirl.create(:student_profile)
            sp.add_or_update_college_status(college, "Just a Fan")
          end
        end
        get :home, order: "pop"
        expect(assigns(:colleges).map(&:name)).to eql(%w[ccc bbb aaa])
      end
    end
  end

  context "when user is not signed in" do
    it "redirects to the root path" do
      get :home
      expect(response).to redirect_to(root_path)
    end
  end
end
