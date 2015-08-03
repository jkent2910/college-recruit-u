require 'rails_helper'

RSpec.describe Photo, type: :model do
  it "belongs_to college" do
    expect(subject).to belong_to :college
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
end
