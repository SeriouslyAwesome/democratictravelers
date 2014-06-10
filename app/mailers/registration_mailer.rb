class RegistrationMailer < ActionMailer::Base
  default from: 'The Democratic Travelers
    <yourstruly@thedemocratictravelers.com>'

  def conversion(id, password)
    @user = User.find(id)
    @password = password
    mail to: @user.email, subject: 'Welcome! And Thanks!'
  end
end
