require 'rails_helper'

feature 'Posts page' do
  let!(:post) { create(:post) }

  context '(as an admin)' do
    before { login_admin }

    scenario 'shows all posts (including drafts)' do
      post.update(published: false)

      visit archives_path

      expect(page).to have_content post.title
    end
  end
end
