class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env['omniauth.auth'])
    user.mailing_list = 1 if user.email
    if user.persisted?
      flash.notice = 'Signed in!'
      # Uncomment below to see all of the paramaters passed back from
      # the oauth provider:
      # raise request.env['omniauth.auth'].to_yaml
      sign_in_and_redirect user
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to root_url
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all
end
