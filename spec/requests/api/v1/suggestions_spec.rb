require 'rails_helper'

describe 'Suggestions API' do
  let(:user) { create(:user) }

  before :each do
    create(:state, abbr: 'CA', name: 'California')
  end

  describe 'GET /api/v1/suggestions' do
    it 'returns an array of experiences' do
      get api_v1_suggestions_url,
           { suggestion: attributes_for(:suggestion), comment_body: 'spam!' },
           authentication_headers(user)

      expect(json['experiences']).to be
    end
  end

  describe 'POST /api/v1/suggestions' do
    it 'cancels action when honeypot is filled in' do
      post api_v1_suggestions_url,
           { suggestion: attributes_for(:suggestion), comment_body: 'spam!' },
           authentication_headers(user)

      expect(response.status).to be(401)
      expect(Location.count).to eq(0)
      expect(Experience.count).to eq(0)
    end

    it 'requires authentication' do
      post api_v1_suggestions_url, suggestion: attributes_for(:suggestion)
      expect(response.status).to eq(401)
      expect(Location.count).to eq(0)
      expect(Experience.count).to eq(0)
    end

    context '(when signed in)' do
      before :each do
        post api_v1_suggestions_url,
             { suggestion: attributes_for(:suggestion) },
             authentication_headers(user)
      end

      it 'returns a Location' do
        expect(assigns(:location)).to eq(Location.first)
      end

      it 'returns the new Experience' do
        expect(assigns(:experience)).to eq(Experience.first)
      end

      it 'returns a success notice via JSON' do
        expect(json['success']).to eq(true)
      end

      context '(as a guest)' do
        it 'shows a notice' do
          user.update(guest: true)

          post api_v1_suggestions_url,
               { suggestion: attributes_for(:suggestion) },
               authentication_headers(user)

          expect(json['notice']).to be
        end
      end


      context '(and with invalid attributes)' do
        it 'returns errors' do
          post api_v1_suggestions_url,
             { suggestion: attributes_for(:suggestion, experience_name: '') },
             authentication_headers(user)

          expect(json['errors']).to be
        end
      end
    end
  end
end
