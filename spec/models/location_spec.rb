# == Schema Information
#
# Table name: locations
#
#  id                :integer          not null, primary key
#  lat               :float            not null
#  long              :float            not null
#  name              :string(255)
#  address           :string(255)
#  city              :string(255)
#  state_id          :integer
#  zip               :integer
#  country_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  done              :boolean          default(FALSE), not null
#  formatted_address :string(255)
#  current           :boolean          default(FALSE), not null
#  experiences_count :integer          default(0)
#  votes_cache       :integer          default(0), not null
#

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
