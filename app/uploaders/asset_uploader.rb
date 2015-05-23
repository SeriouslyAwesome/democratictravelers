# encoding: utf-8
class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [100, 100]
  end

  version :icon do
    process resize_to_fill: [30, 30]
  end

  version :big do
    process resize_to_fit: [800, 600]
  end
end
