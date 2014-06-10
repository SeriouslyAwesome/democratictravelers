FactoryGirl.define do
  factory :suggestion do
    location_name 'Apple Inc.'
    latitude 37.331741
    longitude(-122.030333)
    address '1 Infinite Loop'
    formatted_address "1 Infinite Loop\nCupertino, CA 95014"
    city 'Cupertino'
    state 'CA'
    experience_name 'Visit Apple Headquarters!'
    description 'So you can try and meet Jony Ive'
  end
end
