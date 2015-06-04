class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    set_user
    if @user.persisted?
      flash.notice = 'Signed in!'
      sign_in_and_redirect @user
    else
      session['devise.user_attributes'] = @user.attributes
      redirect_to root_url
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all

  private

  def set_user
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.mailing_list = 1 if @user.email
  end
end
