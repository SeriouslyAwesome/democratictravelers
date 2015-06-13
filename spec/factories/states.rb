# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  abbr       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  done       :boolean
#

FactoryGirl.define do
  factory :state do
    name 'Florida'
    abbr 'FL'
  end
end
