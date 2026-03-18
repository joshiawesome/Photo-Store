class UserMailer < ApplicationMailer
  default from: 'dfelips@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome!')
  end
end
