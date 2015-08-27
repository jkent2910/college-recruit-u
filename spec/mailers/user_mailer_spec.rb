require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "ask_a_question" do
    before do
      @college = FactoryGirl.create(:college)
      @user = FactoryGirl.create(:user)
      @student_profile = FactoryGirl.create(:student_profile, student: @user)
      @question = "Will I like this college?"
    end

    let(:mail) { UserMailer.ask_a_question(@student_profile, @college, @question) }

    it "renders the headers" do
      expect(mail.subject).to match /question about/i
      expect(mail.to).to eq(EMAIL_ADDRESSES[:college_question])
      expect(mail.from).to eq(["no-reply@collegerecruitu.com"])
      expect(mail.reply_to).to eq([@user.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(@question)
    end
  end

  describe "application_help", type: :mailer do
    before do
      @college = FactoryGirl.create(:college)
      @user = FactoryGirl.create(:user)
      @student_profile = FactoryGirl.create(:student_profile, student: @user)
      @question = "Will I like this college?"
    end

    let(:mail) { UserMailer.application_help(@student_profile, @college, @question) }

    it "renders the headers" do
      expect(mail.subject).to match /help/i
      expect(mail.to).to eq(EMAIL_ADDRESSES[:application_help])
      expect(mail.from).to eq(["no-reply@collegerecruitu.com"])
      expect(mail.reply_to).to eq([@user.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(@question)
    end
  end
end
