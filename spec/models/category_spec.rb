require 'spec_helper'

describe Category do
  it 'is created when all attributes are valid' do
    build(:category).should be_valid
  end

  it 'requires a title' do
    build(:category, name: '').should be_invalid
  end
end
