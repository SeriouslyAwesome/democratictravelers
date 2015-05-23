require 'rails_helper'

describe 'Experiences API' do
  let(:user) { create(:user) }
  let!(:alt_user) { create(:user) }

  describe 'GET /v1/experiences' do
    it 'returns array of all Experiences' do
      create(:experience)
      create(:experience)

      get api_v1_experiences_url, nil, authentication_headers(user)

      expect(response).to be_success
      expect(assigns(:experiences).count).to be(2)
      expect(json['experiences'].length).to eq(2)
    end
  end

  describe 'GET /v1/experiences/:id' do
    it 'returns the requested Experience' do
      create(:experience, name: 'First')
      second = create(:experience, name: 'Second')

      get api_v1_experience_url('second'), nil, authentication_headers(user)

      expect(response).to be_success
      expect(assigns(:experience)).to eq(second)
      expect(json['experiences'][0]['name']).to eq('Second')
    end
  end

  let(:experience) { create(:experience, name: 'Old', user: user) }

  describe 'PATCH /v1/experiences/:id' do
    it 'requires authentication' do
      patch api_v1_experience_url(experience),
          experience: attributes_for(:experience, name: 'New')

      expect(response.status).to be(401)
    end

    context '(when authenticated)' do
      context '(and attributes are valid)' do
        it 'returns the updated experience' do
          patch api_v1_experience_url(experience),
              { experience: attributes_for(
                  :experience, name: 'New', user: user
                )
              }, authentication_headers(user)

          expect(response.status).to eq(200)
          expect(json['name']).to eq('New')
        end
      end

      context '(as a different user)' do
        it 'returns status 403' do
          patch api_v1_experience_url(experience),
              { experience: attributes_for(
                  :experience, name: nil, user_id: 5
                )
              }, authentication_headers(alt_user)

          expect(response.status).to eq(403)
        end
      end
    end
  end

  describe 'PUT /v1/experiences/:id' do
    it 'requires authentication' do
      put api_v1_experience_url(experience),
          experience: attributes_for(:experience, name: 'New')

      expect(response.status).to be(401)
    end

    context '(when authenticated)' do
      context '(and attributes are valid)' do
        it 'returns the updated experience' do
          put api_v1_experience_url(experience),
              { experience: attributes_for(
                  :experience, name: 'New', user: user
                )
              }, authentication_headers(user)

          expect(response.status).to eq(200)
          expect(json['name']).to eq('New')
        end
      end

      context '(as a different user)' do
        it 'returns status 403' do
          put api_v1_experience_url(experience),
              { experience: attributes_for(
                  :experience, name: nil, user_id: 5
                )
              }, authentication_headers(alt_user)

          expect(response.status).to eq(403)
        end
      end
    end
  end

  describe 'POST /v1/experiences/:id/upvote' do
    it 'requires authentication' do
      post upvote_api_v1_experience_url(experience)

      expect(response.status).to be(401)
    end

    context 'when authenticated' do
      let(:guest) { create(:user) }
      it 'returns the upvoted experience' do
        post upvote_api_v1_experience_url(experience),
             nil, authentication_headers(guest)

        expect(response.status).to be(200)
        expect(assigns(:experience).votes_cache).to eq(2)
      end
    end
  end

  describe 'POST /v1/experiences/:id/downvote' do
    it 'requires authentication' do
      post downvote_api_v1_experience_url(experience)

      expect(response.status).to be(401)
    end

    context 'when authenticated' do
      let(:guest) { create(:user) }
      it 'returns the upvoted experience' do
        post downvote_api_v1_experience_url(experience),
             nil, authentication_headers(guest)

        expect(response.status).to be(200)
        expect(assigns(:experience).votes_cache).to eq(0)
      end
    end
  end

  describe 'POST /v1/experiences/:id/done' do
    it 'requires authentication' do
      post done_api_v1_experience_url(experience)

      expect(response.status).to be(401)
    end

    it 'requries admin authorization' do
      post done_api_v1_experience_url(experience),
           nil, authentication_headers(user)

      expect(response.status).to be(403)
    end

    context 'when authorized' do
      it 'returns the updated Experience' do
        user.add_role(:admin)

        post done_api_v1_experience_url(experience),
             nil, authentication_headers(user)

        expect(response.status).to be(200)
        expect(response).to render_template('api/v1/experiences/done')
        expect(json['done']).to be(true)
      end
    end
  end

  describe 'DELETE /v1/experiences/:id' do
    it 'requires admin authorization' do
      delete api_v1_experience_url(experience),
             nil, authentication_headers(user)

      expect(response.status).to be(403)
    end

    context 'when authorized' do
      before { user.add_role(:admin) }

      it 'returns nothing' do
        delete api_v1_experience_url(experience),
               nil, authentication_headers(user)

        expect(response.status).to be(200)
      end
    end
  end
end
