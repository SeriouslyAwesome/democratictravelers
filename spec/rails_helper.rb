require "codeclimate-test-reporter"
require 'simplecov'

CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']
SimpleCov.start 'rails'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'
require 'capybara/email/rspec'
require 'sidekiq/testing'
Sidekiq::Testing.inline!
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/poltergeist'

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.run_all_when_everything_filtered = true

  config.include AbstractController::Translation
  config.include FactoryGirl::Syntax::Methods
  config.include FactoryGirl::Syntax:: Methods
  config.include Devise::TestHelpers, type: :controller
  config.include FeatureMacros, type: :feature
  config.include ControllerMacros, type: :controller
  config.include RequestMacros, type: :request

  config.before(:each) do |example|
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

  # config.before :each, :js, type: :feature do |example|
  #   # Everything is terrible. js: true in config.before will run if the js tag
  #   # is present in the spec declaration, regardless of the value.
  #   if example.metadata[:js]
  #     page.driver.block_unknown_urls
  #     page.driver.allow_url("a.tiles.mapbox.com")
  #     page.driver.allow_url("b.tiles.mapbox.com")
  #     page.driver.allow_url("api.democratictravelers.dev")
  #   end
  # end
end
