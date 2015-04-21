require 'rails_helper'

describe CategoryConnection do
  it 'is created when all attributes are valid' do
    expect(build(:category_connection)).to be_valid
  end

  it 'requires a category ID' do
    expect(build(:category_connection, category_id: nil)).to be_invalid
  end

  it 'requires a \'Connectable\' object' do
    expect(build(:category_connection, connectable_id: nil)).to be_invalid
    expect(build(:category_connection, connectable_type: nil)).to be_invalid
  end
end
