require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #search" do
    before do
      post :search, query: 'Smith'
    end

    it "assigns student profile search results to @students" do
      expect(assigns[:students]).to be_a StudentProfile::ActiveRecord_Relation
    end

    it "assigns college search results to @colleges" do
      expect(assigns[:colleges]).to be_a College::ActiveRecord_Relation
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end
  end

  specify "search excludes incognito student profiles" do
    student_profile = FactoryGirl.create(:student_profile, first_name: "Maggie", incognito: false)
    incognito_profile = FactoryGirl.create(:student_profile, first_name: "Maggie", incognito: true)
    post :search, query: "Maggie"
    expect(assigns(:students)).to include(student_profile)
    expect(assigns(:students)).not_to include(incognito_profile)
  end
end
