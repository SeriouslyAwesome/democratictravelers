FactoryBot.define do
  factory :location do
    lat { 26.679457 }
    long { -80.053462 }
    name { 'Mom\'s House' }
    address { '320 Monroe Drive' }
    city { 'West Palm Beach' }
    association :state, strategy: :create
    zip { '33405' }
    country_id { 228 }
  end
end
