Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = ENV['CI'].present?

  config.public_file_server.enabled = true
  config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=3600' }

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.cache_store = :null_store

  config.action_dispatch.show_exceptions = :rescuable

  config.action_controller.allow_forgery_protection = false

  config.active_job.queue_adapter = :inline
  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = { host: 'test.democratictravelers.dev' }

  config.active_support.deprecation = :stderr
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
end
