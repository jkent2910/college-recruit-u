class UserMailer < ApplicationMailer
  def ask_a_question(student_profile, college, question)
    @student_profile = student_profile
    @college = college
    @question = question

    mail subject: "Question about #{@college.name}", reply_to: [@student_profile.student.email], to: EMAIL_ADDRESSES[:college_question]
  end
end
