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

require 'rails_helper'

describe User do
  it 'is created when all attributes are valid' do
    expect(build(:user)).to be_valid
  end

  it 'is given basic user role on creation' do
    user = create(:user)
    expect(user.reload.has_role? :user).to eq(true)
  end

  it 'does not have admin priveleges by default' do
    user = create(:user)
    expect(user.reload.has_role? :admin).to eq(false)
  end

  describe '.authentication_token' do
    it 'is generated if not present' do
      user = create(:user)
      expect(user.authentication_token).to_not be_nil
    end
  end

  describe '.email' do
    it 'requires an email address' do
      expect(build(:user, email: '')).to_not be_valid
    end

    it 'accepts valid email addresses' do
      addresses = ['user@foo.com', 'THE_USER@foo.bar.org', 'first.last@foo.jp']
      addresses.each do |address|
        expect(build(:user, email: address)).to be_valid
      end
    end

    it 'rejects duplicate email addresses' do
      create(:user, email: 'example@seriouslyawesome.com')
      expect(build(:user, email: 'example@seriouslyawesome.com')).to_not be_valid
    end
    it 'rejects duplicate emails regardless of capitalization' do
      create(:user, email: 'example@seriouslyawesome.com')
      expect(build(:user, email: 'EXAMPLE@SeriouslyAwesome.com')).to_not be_valid
    end
  end

  describe '.password' do
    it 'is required' do
      expect(build(:user)).to respond_to(:password)
      expect(build(:user, password: '')).to_not be_valid
    end

    it 'requires confirmation' do
      expect(build(:user)).to respond_to(:password_confirmation)
      expect(build(:user, password_confirmation: '')).to_not be_valid
    end

    it 'rejects short passwords' do
      expect(build(:user, password: 'F', password_confirmation: 'F')
        ).to_not be_valid
    end

    it 'requires encryption' do
      expect(create(:user).encrypted_password).to_not be_blank
    end
  end

  describe '.name' do
    it 'requires a name' do
      expect(build(:user, name: nil)).to_not be_valid
    end
  end

  it 'must have a default role on create' do
    user = create(:user)
    expect(user.has_role?(:user)).to eq(true)
  end

  it 'responds to .first_name' do
    names = ['John Doe', 'John', 'John  Doe', 'John Awesome Doe']
    names.each do |name|
      expect(build(:user, name: name).first_name).to eq('John')
    end
  end

  it 'responds to .last_name' do
    names = ['John Doe', 'Doe', 'John  Doe', 'John Awesome Doe']
    names.each do |name|
      expect(build(:user, name: name).last_name).to eq('Doe')
    end
  end

  it 'responds to .short_name' do
    names = ['John Doe', 'John  Doe', 'John Awesome Doe']
    names.each do |name|
      expect(build(:user, name: name).short_name).to eq('John D.')
    end
    expect(build(:user, name: 'John').short_name).to eq('John')
  end
end
