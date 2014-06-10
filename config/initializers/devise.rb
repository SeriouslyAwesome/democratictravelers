# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  require 'devise/orm/active_record'

  config.mailer_sender = 'yourstruly@thedemocratictravelers.com'

  config.secret_key = ENV['SECRET_KEY_BASE']

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.http_authenticatable_on_xhr = true

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = true

  config.reset_password_within = 6.hours

  config.http_authenticatable_on_xhr = false

  config.navigational_formats = ['*/*', :html, :json, :js]

  config.sign_out_via = Rails.env.test? ? :get : :delete

  config.omniauth :twitter, ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']

  config.omniauth :facebook, ENV['FACEBOOK_API_KEY'],
                             ENV['FACEBOOK_API_SECRET']
end
