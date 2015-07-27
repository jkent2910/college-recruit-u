require 'rails_helper'

RSpec.describe "search/index.html.erb", type: :view do
  context "when there are search results" do
    before do
      FactoryGirl.create(:student_profile, first_name: "Jane", last_name: "Smith")
      FactoryGirl.create(:college, name: "Smith College")
      query = "smith"
      @students = StudentProfile.search(query)
      @colleges = College.search(query)
    end

    it "displays a list of students" do
      render
      expect(rendered).to have_content("Jane Smith")
    end


    it "displays a list of colleges" do
      render
      expect(rendered).to have_content("Smith College")
    end
  end

  context "when there are no search results" do
    before do
      @students = []
      @colleges = []
    end

    it "displays an appropriate message if no students are found" do
      render
      expect(rendered).to have_content("No students were found.")
    end

    it "displays an appropriate message if no colleges are found" do
      render
      expect(rendered).to have_content("No colleges were found")
    end
  end

end
