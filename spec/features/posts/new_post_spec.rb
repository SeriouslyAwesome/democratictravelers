require 'rails_helper'

feature 'New blog post' do
  let!(:experience) { create(:experience, done: true) }

  before do
    login_admin
    visit new_post_path
  end

  context '(when attributes are invalid)' do
    scenario 're-renders the new post form' do
      fill_in 'post[excerpt]', with: 'stuff'
      fill_in 'post[body]', with: 'more stuff'

      click_button 'Post This Bitch!'

      expect(page).to have_content 'Notify related users'
    end
  end

  context '(when attributes are valid)' do
    context '(and \'Notify Contributors\' is checked)' do
      scenario 'sends mailers to experience submitters' do
        fill_in 'post[title]', with: 'title'
        fill_in 'post[excerpt]', with: 'stuff'
        fill_in 'post[body]', with: 'more stuff'

        check "#{experience.name_for_checkboxes}"
        check 'Notify related users of this post?'
        click_button 'Post This Bitch!'

        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
  end

  scenario 'allows for image uploads', vcr: true, js: true, record: :new_episodes do
    attach_file('asset[asset]', File.absolute_path('./spec/files/test_image.jpg'), visible: false)
    fill_in 'post[title]', with: 'title'
    fill_in 'post[excerpt]', with: 'stuff'
    fill_in 'post[body]', with: 'more stuff'

    asset = Asset.last
    within "#asset_#{asset.id}" do
      find('.asset-toggle-cover').click
    end

    click_button 'Post This Bitch!'
    post = Post.last

    expect(post.assets.count).to eq(1)
  end
end
