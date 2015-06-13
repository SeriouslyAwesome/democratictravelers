# == Schema Information
#
# Table name: experiences
#
#  id          :integer          not null, primary key
#  location_id :integer          not null
#  name        :string(255)      not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  distance    :float
#  votes_cache :integer          default(0), not null
#  slug        :string(255)
#  done        :boolean          default(FALSE), not null
#

FactoryGirl.define do
  factory :experience do
    location_id 1
    name 'Barbecue at Mom\'s'
    description 'It\'s not very far away, so you won\'t need the Airstream.'
    location
    user
    distance 30.00
  end
end
