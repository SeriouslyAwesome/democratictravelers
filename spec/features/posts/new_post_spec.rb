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

  skip 'allows for image uploads' do
    attach_file('Add Images...', File.absolute_path('./spec/files/test.jpg'))
    fill_in 'post[title]', with: 'title'
    fill_in 'post[excerpt]', with: 'stuff'
    fill_in 'post[body]', with: 'more stuff'

    save_and_open_page

    click_button 'Post This Bitch!'

    post = Post.last

    expect(post.assets.count).to eq(1)
  end
end
