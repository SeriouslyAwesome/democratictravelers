require 'spec_helper'

describe CategoryConnection do
  it 'is created when all attributes are valid' do
    build(:category_connection).should be_valid
  end

  it 'requires a category ID' do
    build(:category_connection, category_id: nil).should be_invalid
  end

  it 'requires a \'Connectable\' object' do
    build(:category_connection, connectable_id: nil).should be_invalid
    build(:category_connection, connectable_type: nil).should be_invalid
  end
end
