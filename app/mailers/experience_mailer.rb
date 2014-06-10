class ExperienceMailer < ActionMailer::Base
  default from: 'yourstruly@thedemocratictravelers.com'

  def we_did_this(id)
    @experience = Experience.friendly.find(id)
    @user = @experience.user
    mail(to: @user.email, subject: 'We just took your suggestion!')
  end

  def we_blogged_this(id)
    @experience = Experience.friendly.find(id)
    @user = @experience.user
    mail(to: @user.email, subject: 'We wrote about your suggestion!')
  end
end
