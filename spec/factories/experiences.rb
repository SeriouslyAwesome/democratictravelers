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
