require 'codeclimate-test-reporter'
require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/email/rspec'
require 'sidekiq/testing'

Sidekiq::Testing.inline!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.run_all_when_everything_filtered = true

  config.include AbstractController::Translation
  config.include FactoryGirl::Syntax::Methods
  config.include FactoryGirl::Syntax:: Methods
  config.include Devise::TestHelpers, type: :controller
  config.include FeatureMacros, type: :feature
  config.include ControllerMacros, type: :controller
  config.include RequestMacros, type: :request
  config.include OmniAuthTestHelper, type: :request

  OmniAuth.config.test_mode = true

  config.before(:each) do |example|
    OmniAuth.config.mock_auth[:twitter] = nil
    OmniAuth.config.mock_auth[:facebook] = nil
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    ActionMailer::Base.deliveries = []
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end

  Capybara.javascript_driver = :selenium
  Capybara.asset_host = "http://localhost:5000"
  Capybara.server_port = 53023
end
