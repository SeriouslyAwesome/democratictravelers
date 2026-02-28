Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  # Allow all hosts in development
  config.hosts.clear

  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = { 'Cache-Control' => "public, max-age=#{2.days.to_i}" }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # ActionMailer Config
  config.action_mailer
    .default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default charset: 'utf-8'

  config.action_mailer.smtp_settings = {
    address: 'smtp.mandrillapp.com',
    port: 587,
    enable_starttls_auto: true,
    authentication: 'login',
    domain: 'thedemocratictravelers.com',
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD']
  }

  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
  config.log_level = :debug

  config.active_record.migration_error = :page_load

  config.assets.debug = true
  config.assets.quiet = true
end
