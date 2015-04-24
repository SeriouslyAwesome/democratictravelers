require 'rails_helper'

describe ExperiencesWorker do
  describe '#perform' do
    it 'does something' do
      experience = create(:experience)
      location = create(:location)
      expect{ ExperiencesWorker.perform_async(location.id) }.to_not raise_error
    end
  end
end
