require 'rails_helper'

feature 'Edit blog post' do
  let!(:post) { create(:post) }
  before { login_admin }

  context '(when attributes are invalid)' do
    scenario 're-renders the edit post form' do
      visit edit_post_path(post)

      fill_in 'post[title]', with: ''
      fill_in 'post[excerpt]', with: 'stuff'
      fill_in 'post[body]', with: 'more stuff'

      click_button 'Post This Bitch!'

      expect(page).to have_content 'Notify related users'
    end
  end
end
