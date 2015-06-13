# == Schema Information
#
# Table name: locations
#
#  id                :integer          not null, primary key
#  lat               :float            not null
#  long              :float            not null
#  name              :string(255)
#  address           :string(255)
#  city              :string(255)
#  state_id          :integer
#  zip               :integer
#  country_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  done              :boolean          default(FALSE), not null
#  formatted_address :string(255)
#  current           :boolean          default(FALSE), not null
#  experiences_count :integer          default(0)
#  votes_cache       :integer          default(0), not null
#

FactoryGirl.define do
  factory :location do
    lat 26.679457
    long(-80.053462)
    name 'Mom\'s House'
    address '320 Monroe Drive'
    city 'West Palm Beach'
    state
    zip '33405'
    country_id 228
  end
end
