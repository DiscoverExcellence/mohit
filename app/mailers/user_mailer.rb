class UserMailer < ApplicationMailer
  default from: "mohit@joshsoftware.com"
  
  def welcome_email(user)
    @user = user
    @url  = "http://www.google.co.in"
    p "In welcome_email"
    mail(to: @user.email, subject: "welcome to awesome site")
  end

end
