class UserMailer < ActionMailer::Base
  def hello
    mail(:to => "camoorhead@gmail.com", :subject => "Registered", :from => "what@example.com")
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset", :from => "camoorhead@gmail.com"
  end
end
