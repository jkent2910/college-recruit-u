class UserMailer < ApplicationMailer
  def ask_a_question(student_profile, college, question)
    @student_profile = student_profile
    @college = college
    @question = question

    mail subject: "Question about #{@college.name}", reply_to: [@student_profile.student.email], to: EMAIL_ADDRESSES[:college_question]
  end

  def application_help(student_profile, college, question)
    @student_profile = student_profile
    @college = college
    @question = question

    mail subject: "Help with application for #{@college.name}", reply_to: [@student_profile.student.email], to: EMAIL_ADDRESSES[:application_help]
  end

  def request_a_college(student_profile, question)
    @student_profile = student_profile
    @question = question

    mail subject: "Request a College", reply_to: [@student_profile.student.email], to: EMAIL_ADDRESSES[:request_a_college]
  end

end
