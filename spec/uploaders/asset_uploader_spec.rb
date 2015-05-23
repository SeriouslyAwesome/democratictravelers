require 'rails_helper'

describe AssetUploader do
  describe '#store_dir' do
    it 'returns a string' do
      asset = build(:asset)
      uploader = AssetUploader.new(asset)
      expect(uploader.store_dir).to be_a(String)
    end
  end
end
