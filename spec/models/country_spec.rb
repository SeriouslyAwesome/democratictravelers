require 'rails_helper'

describe Country do
  it 'is created when all attributes are valid' do
    expect(build(:country)).to be_valid
  end

  it 'requires a name' do
    expect(build(:country, name: nil)).to be_invalid
  end

  it 'requires a country code' do
    expect(build(:country, code: nil)).to be_invalid
  end

  it 'requires country code to be 2 or 3 characters' do
    expect(build(:country, code: 'REBELLION!')).to be_invalid
  end
end
