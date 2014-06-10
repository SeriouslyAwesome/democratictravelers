require 'spec_helper'

describe Location do
  it 'is created when all attributes are valid' do
    build(:location).should be_valid
  end

  it 'requires a state' do
    build(:location, state_id: '').should be_invalid
  end

  it 'correctly references the state it\'s in' do
    create(:state)
    sample = create(:location)
    sample.state.name.should eq('Florida')
  end

  describe '.zip' do
    it 'is not required' do
      build(:location, zip: '').should be_valid
    end
  end

  describe '.lat (latitude)' do
    it 'is required' do
      build(:location, lat: '').should be_invalid
    end

    it 'must be a number' do
      lats = ['Winning!', 'h4x0r3d', 'fail']
      lats.each do |lat|
        build(:location, lat: lat).should be_invalid
      end
    end
  end

  describe '.long (longitude)' do
    it 'is required' do
      build(:location, long: '').should be_invalid
    end

    it 'must be a number' do
      longs = ['Winning!', 'h4x0r3d', 'fail']
      longs.each do |long|
        build(:location, long: long).should be_invalid
      end
    end
  end
end
