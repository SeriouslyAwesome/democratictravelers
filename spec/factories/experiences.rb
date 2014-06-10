FactoryGirl.define do
  factory :experience do
    location_id 1
    name 'Barbecue at Mom\'s'
    description 'It\'s not very far away, so you won\'t need the Airstream.'
    starts '2012-12-06 10:43:58'
    ends '2012-12-06 15:43:58'
    location
    user
  end
end
