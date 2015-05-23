require 'rails_helper'

describe HomeController do
  render_views

  let!(:current) { create(:location, current: true) }

  describe 'GET #index' do
    it 'renders home/index template' do
      get :index
      expect(response).to render_template('home/index')
    end
  end

  describe 'GET #map' do
    it 'renders the home/map template' do
      get :map
      expect(response).to render_template('home/map')
    end
  end

  describe 'GET #about' do
    it 'renders the home/about template' do
      get :about
      expect(response).to render_template('home/about')
    end
  end

  describe 'GET #colophon' do
    it 'renders the home/colophon template' do
      get :colophon
      expect(response).to render_template('home/colophon')
    end
  end

  describe 'GET #sitemap' do
    it 'renders home/sitemap.xml' do
      # post = create(:post)
      # user = create(:user)
      # current_location = create(:location, current: true)
      # exp = create(:experience, user: user)

      # get :sitemap, format: :xml
      # expect(response).to render_template('home/sitemap.xml')
    end
  end
end
