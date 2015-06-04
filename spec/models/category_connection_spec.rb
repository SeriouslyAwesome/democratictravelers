require 'rails_helper'

describe CategoryConnection do
  it { should belong_to(:category) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:connectable) }
end
