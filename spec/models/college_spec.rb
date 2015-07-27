require 'rails_helper'

RSpec.describe College, type: :model do
  context "validations" do
    [:name, :college_type, :city, :state, :region].each do |attr|
      it "validates presence of #{attr}" do
        expect(subject).to validate_presence_of(attr)
      end
    end
  end

  context "search" do
    before do
      @college1 = FactoryGirl.create(:college, name: "University of Iowa")
      @college2 = FactoryGirl.create(:college, name: "Iowa State University")
      @college3 = FactoryGirl.create(:college, name: "Drake Unviversity")
    end

    it "is searchable by name" do
      expect(College.search("iowa")).to contain_exactly(@college1, @college2)
    end
  end
end
