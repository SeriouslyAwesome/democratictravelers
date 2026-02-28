CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/tmp/uploads"

  if Rails.env.production? || Rails.env.development?
    config.storage = :aws
    config.aws_acl = 'public-read'
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365
    config.aws_bucket = ENV['S3_BUCKET']

    config.aws_credentials = {
      access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV.fetch('AWS_REGION', 'us-east-1')
    }
  elsif Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  end
end
