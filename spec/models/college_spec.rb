require 'rails_helper'

RSpec.describe College, type: :model do
  context "validations" do
    [:name, :type, :city, :state, :region].each do |attr|
      it "validates presence of #{attr}" do
        expect(subject).to validate_presence_of(attr)
      end
    end
  end
end