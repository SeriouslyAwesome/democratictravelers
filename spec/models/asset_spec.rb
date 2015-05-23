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
