require 'spec_helper'

describe Country do
  it 'is created when all attributes are valid' do
    build(:country).should be_valid
  end

  it 'requires a name' do
    build(:country, name: nil).should be_invalid
  end

  it 'requires a country code' do
    build(:country, code: nil).should be_invalid
  end

  it 'requires country code to be 2 or 3 characters' do
    build(:country, code: 'REBELLION!').should be_invalid
  end
end
