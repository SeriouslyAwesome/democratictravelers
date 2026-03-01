Devise.setup do |config|
  require 'devise/orm/active_record'

  config.mailer_sender = 'yourstruly@thedemocratictravelers.com'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.http_authenticatable_on_xhr = false
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.reset_password_within = 6.hours
  config.navigational_formats = ['*/*', :html, :json, :js]
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  config.omniauth :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
  config.omniauth :facebook, ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_API_SECRET']
end
