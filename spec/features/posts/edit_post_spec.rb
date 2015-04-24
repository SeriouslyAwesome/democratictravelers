require 'rails_helper'

feature 'Edit blog post', vcr: true, js: true, record: :new_episodes do
  let!(:post) { create(:post) }

  before do
    login_admin
    visit edit_post_path(post)
  end

  context '(when attributes are invalid)' do
    scenario 're-renders the edit post form' do
      fill_in 'post[title]', with: ''
      fill_in 'post[excerpt]', with: 'stuff'
      fill_in 'post[body]', with: 'more stuff'

      click_button 'Post This Bitch!'

      expect(page).to have_content 'Notify related users'
    end
  end

  scenario 'allows me to delete assets' do
    asset = post.assets.first
    within "#asset_#{asset.id}" do
      find('.asset-delete').click
    end

    page.driver.browser.switch_to.alert.accept

    click_button 'Post This Bitch!'

    expect(post.reload.assets.count).to eq(0)
  end
end
