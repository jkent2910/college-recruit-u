# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/ask_a_question
  def ask_a_question
    UserMailer.ask_a_question
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/application_help
  def application_help
    UserMailer.application_help
  end

end
