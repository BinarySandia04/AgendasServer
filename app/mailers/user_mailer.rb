class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: @user.name + ", confirma el teu correu electrònic")
  end
end
