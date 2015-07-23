require 'rails_helper'

RSpec.describe StudentProfile, type: :model do
  context "validations" do
    [:first_name, :last_name, :gender, :high_school, :graduation_year].each do |attr|
      it "validates presence of #{attr}" do
        expect(subject).to validate_presence_of(attr)
      end
    end

    it "allows only valid graduation years" do
      expect(subject).to validate_inclusion_of(:graduation_year).in_array(StudentProfile::VALID_GRADUATION_YEARS)
    end

    it "allows valid student interests" do
      student_profile = FactoryGirl.build(:student_profile, interests: ['Basketball', 'Choir'])
      expect(student_profile).to be_valid
    end

    it "doesn't allow invalid student interests" do
      student_profile = FactoryGirl.build(:student_profile, interests: ['bogus'])
      expect(student_profile).to be_invalid
      expect(student_profile.errors[:interests]).to include(a_string_matching /invalid interest/ )
    end
  end

  describe "photo" do
    it "is an attachment" do
      expect(subject).to have_attached_file(:photo)
    end

    it "validates the file type" do
      expect(subject).to validate_attachment_content_type(:photo).
                          allowing("image/png", "image/gif", "image/jpeg").
                          rejecting("text/html", "bogus/whatever")
    end

    it "validates the file size" do
      expect(subject).to validate_attachment_size(:photo).less_than(2.megabytes)
    end
  end

  context "relationships" do
    it "belongs to student" do
      expect(subject).to belong_to :student
    end

    it "has many fan relationships" do
      expect(subject).to have_many :fan_relationships
    end

    it "has many fan of relationships" do
      expect(subject).to have_many :fan_of_relationships
    end

    it "has many fans" do
      expect(subject).to have_many :fans
    end

    it "is a fan of many" do
      expect(subject).to have_many :fan_of
    end

    it "has many factor ratings" do
      expect(subject).to have_many :factor_ratings
    end

    it "has many factors" do
      expect(subject).to have_many :factors
    end

    it "has many colleges" do
      expect(subject).to have_many :colleges
    end

    it "has many college student statuses" do
      expect(subject).to have_many :college_student_statuses
    end

    context "when student profile is deleted" do
      before do
        @student_profile = FactoryGirl.create(:student_profile)
        other_profile = FactoryGirl.create(:student_profile)
        factor = FactoryGirl.create(:factor)
        @student_profile.become_fan_of(other_profile)
        other_profile.become_fan_of(@student_profile)
        @student_profile.factor_ratings << FactoryGirl.create(:factor_rating, factor: factor)
      end

      specify "setup is correct" do
        expect(StudentProfile.count).to eq 2
        expect(Factor.count).to eq 1
        expect(FactorRating.count).to eq 1
        expect(Relationship.count).to eq 2
      end

      specify "student profile is deleted" do
        expect { @student_profile.destroy }.to change { StudentProfile.count }.by(-1)
      end

      specify "fan relationships are deleted" do
        expect { @student_profile.destroy }.to change { Relationship.count }.by(-2)
      end

      specify "factor ratings are deleted" do
        expect { @student_profile.destroy }.to change { FactorRating.count }.by(-1)
      end
    end
  end

  it "returns a full name based on first name and last name" do
    subject.first_name = "John"
    subject.last_name = "Jones"
    expect(subject.full_name).to eql "John Jones"
  end

  context "fandom" do
    before do
      @student_profile = FactoryGirl.create(:student_profile)
      @other_profile = FactoryGirl.create(:student_profile)
    end

    it "can test whether the student is a fan of another student" do
      expect(@student_profile).not_to be_fan_of(@other_profile)
    end

    it "can become a fan of another student" do
      @student_profile.become_fan_of(@other_profile)
      expect(@student_profile).to be_fan_of(@other_profile)
    end

    it "won't become a fan of another student more than once" do
      @student_profile.become_fan_of(@other_profile)
      @student_profile.become_fan_of(@other_profile)
      expect(@student_profile.fan_of).to contain_exactly(@other_profile)
    end

    it "can stop being a fan of another student" do
      @student_profile.become_fan_of(@other_profile)
      @student_profile.stop_being_a_fan_of(@other_profile)
      expect(@student_profile).not_to be_fan_of(@other_profile)
    end
  end

  context "college statuses" do
    before do
      @student_profile = FactoryGirl.create(:student_profile)
      @college = FactoryGirl.create(:college)
    end

    it "can add a college status when one doesn't already exist" do
      expect(@student_profile.colleges).to be_empty
      @student_profile.add_or_update_college_status(@college, 'Just a Fan')
      expect(@student_profile.colleges).to include(@college)
    end

    it "can update a college status when one alread exists" do
      @student_profile.add_or_update_college_status(@college, 'Just a Fan')
      expect(@student_profile.colleges).to include(@college)
      expect(@student_profile.college_student_statuses.first.status_name).to eq 'Just a Fan'
      @student_profile.add_or_update_college_status(@college, 'Applying')
      expect(@student_profile.college_student_statuses.first.status_name).to eq 'Applying'
    end

    it "can't add an invalid college status" do
      expect do
        @student_profile.add_or_update_college_status(@college, 'something else')
      end.to raise_exception ActiveRecord::RecordInvalid
    end

    it "returns the college student status when adding or updating" do
      status = @student_profile.add_or_update_college_status(@college, 'Just a Fan')
      expect(status).to be_a(CollegeStudentStatus)
    end
  end

  context "search" do
    before do
      @student1 = FactoryGirl.create(:student_profile, first_name: "Charlie", last_name: "Puth", high_school: "Ankeny Centential High School")
      @student2 = FactoryGirl.create(:student_profile, first_name: "Meghan", last_name: "Trainor", high_school: "Ankeny High School")
      @student3 = FactoryGirl.create(:student_profile, first_name: "Charlie", last_name: "Sheen", high_school: "Valley High School")
    end

    it "is searchable by first name" do
      expect(StudentProfile.search("Charlie")).to contain_exactly(@student1, @student3)
    end

    it "is searchable by last name" do
      expect(StudentProfile.search("train")).to contain_exactly(@student2)
    end

    it "is searchable by high school" do
      expect(StudentProfile.search("ankeny")).to contain_exactly(@student1, @student2)
    end

    it "is searchable by more than one word" do
      expect(StudentProfile.search("meg ankeny")).to contain_exactly(@student2)
    end

    it "can return no records" do
      expect(StudentProfile.search("charlie sheen ankeny")).to be_empty
    end
  end
end
