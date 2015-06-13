# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  provider               :string(255)
#  email                  :string(255)      default("")
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  uid                    :string(255)
#  location               :string(255)
#  username               :string(255)
#  timezone               :integer
#  mailing_list           :boolean
#  uuid                   :string(255)
#  referring_url          :text
#  landing_url            :text
#  authentication_token   :string(255)
#  guest                  :boolean          default(FALSE), not null
#

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
