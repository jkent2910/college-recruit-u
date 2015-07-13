require 'rails_helper'

RSpec.describe CollegesController, type: :controller do
  include Devise::TestHelpers

  before do
    @sarah = FactoryGirl.create(:sarah)
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
    it "assigns the requested college as @college" do
        college = FactoryGirl.create(:college)
        get :show, {:id => college.to_param}
        expect(assigns(:college)).to eq(college)
    end
  end
end
