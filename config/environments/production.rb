Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true

  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present? || true
  config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=31536000' }

  config.assets.js_compressor = :terser
  config.assets.compile = false
  config.assets.digest = true

  config.force_ssl = true
  config.log_level = :info
  config.log_formatter = ::Logger::Formatter.new
  config.log_tags = [:request_id]

  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false

  config.action_mailer
    .default_url_options = { host: 'www.thedemocratictravelers.com' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default charset: 'utf-8'

  config.action_mailer.smtp_settings = {
    address: 'smtp.mandrillapp.com',
    port: 587,
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD']
  }
end
