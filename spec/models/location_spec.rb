require 'rails_helper'

describe Location do
  it 'is created when all attributes are valid' do
    expect(build(:location)).to be_valid
  end

  it 'requires a state' do
    expect(build(:location, state_id: '')).to be_invalid
  end

  it 'correctly references the state it\'s in' do
    create(:state)
    sample = create(:location)
    expect(sample.state.name).to eq('Florida')
  end

  describe '.zip' do
    it 'is not required' do
      expect(build(:location, zip: '')).to be_valid
    end
  end

  describe '.lat (latitude)' do
    it 'is required' do
      expect(build(:location, lat: '')).to be_invalid
    end

    it 'must be a number' do
      lats = ['Winning!', 'h4x0r3d', 'fail']
      lats.each do |lat|
        expect(build(:location, lat: lat)).to be_invalid
      end
    end
  end

  describe '.long (longitude)' do
    it 'is required' do
      expect(build(:location, long: '')).to be_invalid
    end

    it 'must be a number' do
      longs = ['Winning!', 'h4x0r3d', 'fail']
      longs.each do |long|
        expect(build(:location, long: long)).to be_invalid
      end
    end
  end
end
