class NotificationsMailer < ApplicationMailer
  def confirmation_mailer(user)
    @user = user
    mail(to: @user.email_address, subject: 'Welcome to Our #tech blog', from: '#tech blog<erik362926@gmail.com>')
  end
end
