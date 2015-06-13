# == Schema Information
#
# Table name: category_connections
#
#  id               :integer          not null, primary key
#  category_id      :integer
#  connectable_id   :integer
#  connectable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

describe CategoryConnection do
  it { should belong_to(:category) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:connectable) }
end
