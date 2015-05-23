require 'rails_helper'

describe Category do
  it 'is created when all attributes are valid' do
    expect(build(:category)).to be_valid
  end

  it 'requires a title' do
    expect(build(:category, name: '')).to be_invalid
  end
end
