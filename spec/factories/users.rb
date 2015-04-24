FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@example.com"
  end

  sequence :username do |n|
    "testuser#{n}"
  end

  factory :user do
    name 'Test User'
    email
    username
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now

    factory :admin do
      after(:create) do |user|
        user.add_role(:admin)
      end
    end
  end
end
