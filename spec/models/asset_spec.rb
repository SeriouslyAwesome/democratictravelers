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

require 'rails_helper'

describe Asset, type: :model do
  it { should belong_to(:assetable) }
  it { should respond_to(:cover?) }

  describe '#alt_name', vcr: true, record: :new_episodes do
    let(:asset) { create(:image) } # spec/files/test_image.jpg

    it 'replaces dashes and underscores with spaces' do
      expect(asset.alt_name).to eq('test image')
    end
  end
end
