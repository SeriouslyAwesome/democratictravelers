# == Schema Information
#
# Table name: assets
#
#  id             :integer          not null, primary key
#  type           :string(255)
#  asset          :string(255)
#  checksum       :string(255)
#  path           :string(255)
#  filesize       :integer
#  width          :integer
#  height         :integer
#  duration       :integer
#  bit_rate       :integer
#  assetable_id   :integer
#  assetable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  position       :integer
#  cover          :boolean
#  title          :string(255)
#  description    :text
#  caption        :string(255)
#

class Asset < ActiveRecord::Base
  # SCOPES
  scope :cover, -> { where(cover: true) }

  # ASSOCIATIONS
  belongs_to :assetable, polymorphic: true

  # MACROS
  mount_uploader :asset, AssetUploader
  include Rails.application.routes.url_helpers

  # INSTANCE METHODS
  def alt_name
    asset.file.filename.split('.').first.gsub(/[_,-]/, ' ')
  end
end
