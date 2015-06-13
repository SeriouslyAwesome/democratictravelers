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

FactoryGirl.define do
  factory :asset do
    title 'A File Uploaded'
    description 'A descriptive sentence.'
    caption 'The short caption.'

    factory :image do
      asset File.open(File.join(Rails.root, '/spec/files/test_image.jpg'))
    end
  end
end
