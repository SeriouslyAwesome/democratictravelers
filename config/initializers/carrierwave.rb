CarrierWave.configure do |config|
  config.storage = :aws
  config.aws_bucket = ENV['S3_BUCKET']
  config.aws_acl = :public_read
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    bucket_name: ENV['AWS_BUCKET_NAME']
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
