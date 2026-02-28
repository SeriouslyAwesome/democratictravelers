require_relative 'boot'

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module DemocraticTravelers
  class Application < Rails::Application
    config.load_defaults 7.2

    config.exceptions_app = routes

    config.generators do |g|
      g.test_framework :rspec, fixtures: true,
                               view_specs: false,
                               helper_specs: false,
                               routing_specs: false,
                               controller_specs: true,
                               request_specs: false

      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.autoload_paths += %W(#{config.root}/lib)

    config.encoding = 'utf-8'
    config.filter_parameters += [:password, :password_confirmation, :passw, :secret, :token, :_key, :crypt, :salt, :certificate, :otp, :ssn]

    config.assets.enabled = true
    config.assets.version = '7.2'
  end
end
