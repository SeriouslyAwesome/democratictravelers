class SuggestionMailer < ActionMailer::Base
  default from: 'yourstruly@thedemocratictravelers.com'

  def new_suggestion(experience_id)
    @experience = Experience.find(experience_id)
    @location = @experience.location
    @user = @experience.user
    mail to: 'yourstruly@thedemocratictravelers.com',
         subject: 'New Suggestion on the Map!'
  end
end
