require 'rails_helper'

RSpec.describe College, type: :model do
  context "validations" do
    [:name, :college_type, :city, :state, :region].each do |attr|
      it "validates presence of #{attr}" do
        expect(subject).to validate_presence_of(attr)
      end
    end
  end

  context "relationships" do
    it "has many college_student_statuses" do
      expect(subject).to have_many :college_student_statuses
    end

    it "has many student_profiles" do
      expect(subject).to have_many :student_profiles
    end

    it "has many photos" do
      expect(subject).to have_many :photos
    end
  end

  context "when college is deleted" do
    before do
      @college = FactoryGirl.create(:college)
      @college.photos << FactoryGirl.create(:photo, college: @college)
    end

    specify "setup is correct" do
      expect(College.count).to eq 1
      expect(Photo.count).to eq 1
    end

    specify "its photos are deleted" do
      expect { @college.destroy }.to change { Photo.count }.by(-1)
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

  describe "logo" do
    it "is an attachment" do
      expect(subject).to have_attached_file(:logo)
    end

    it "validates the file type" do
      expect(subject).to validate_attachment_content_type(:logo).
                          allowing("image/png", "image/gif", "image/jpeg").
                          rejecting("text/html", "bogus/whatever")
    end

    it "validates the file size" do
      expect(subject).to validate_attachment_size(:logo).less_than(2.megabytes)
    end
  end
end
