require 'rails_helper'

describe RegistrationsController do
  describe 'POST #create' do
    it 'creates a new user' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      post :create, user: attributes_for(:user), format: :json
      expect(response).to be_success
    end

    context 'When using Conversion form' do
      before :each do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, user: { name: 'Johnny Test', email: 'example@test.com' }
      end

      it 'generates a new password' do
        expect(User.count).to eq(1)
        expect(User.last.encrypted_password).to_not be_blank
      end

      it 'sends a mailer notification' do
        # expect(RegistrationMailer.deliveries.last).to be
      end
    end
  end
end
