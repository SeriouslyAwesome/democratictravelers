# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  post_count  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string(255)
#  position    :integer          default(0), not null
#

require 'rails_helper'

describe Category do
  it 'is created when all attributes are valid' do
    expect(build(:category)).to be_valid
  end

  it 'requires a title' do
    expect(build(:category, name: '')).to be_invalid
  end
end
