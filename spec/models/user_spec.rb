require 'spec_helper'

describe User do
  it 'is created when all attributes are valid' do
    build(:user).should be_valid
  end

  describe '.email' do
    it 'requires an email address' do
      build(:user, email: '').should_not be_valid
    end

    it 'accepts valid email addresses' do
      addresses = ['user@foo.com', 'THE_USER@foo.bar.org', 'first.last@foo.jp']
      addresses.each do |address|
        build(:user, email: address).should be_valid
      end
    end

    it 'rejects duplicate email addresses' do
      create(:user, email: 'example@seriouslyawesome.com')
      build(:user, email: 'example@seriouslyawesome.com').should_not be_valid
    end
    it 'rejects duplicate emails regardless of capitalization' do
      create(:user, email: 'example@seriouslyawesome.com')
      build(:user, email: 'EXAMPLE@SeriouslyAwesome.com').should_not be_valid
    end
  end

  describe '.password' do
    it 'is required' do
      build(:user).should respond_to(:password)
      build(:user, password: '').should_not be_valid
    end

    it 'requires confirmation' do
      build(:user).should respond_to(:password_confirmation)
      build(:user, password_confirmation: '').should_not be_valid
    end

    it 'rejects short passwords' do
      build(:user, password: 'F', password_confirmation: 'F')
        .should_not be_valid
    end

    it 'requires encryption' do
      create(:user).encrypted_password.should_not be_blank
    end
  end

  describe '.name' do
    it 'requires a name' do
      build(:user, name: nil).should_not be_valid
    end
  end

  it 'must have a default role on create' do
    user = create(:user)
    user.has_role?(:user).should be_true
  end

  it 'responds to .first_name' do
    names = ['John Doe', 'John', 'John  Doe', 'John Awesome Doe']
    names.each do |name|
      build(:user, name: name).first_name.should eq('John')
    end
  end

  it 'responds to .last_name' do
    names = ['John Doe', 'Doe', 'John  Doe', 'John Awesome Doe']
    names.each do |name|
      build(:user, name: name).last_name.should eq('Doe')
    end
  end

  it 'responds to .short_name' do
    names = ['John Doe', 'John  Doe', 'John Awesome Doe']
    names.each do |name|
      build(:user, name: name).short_name.should eq('John D.')
    end
    build(:user, name: 'John').short_name.should eq('John')
  end
end
