require 'rails_helper'

feature 'Atom Feed' do
  context '(when requested as RSS)' do
    scenario 'redirects to Atom feed' do
      visit feed_path(format: :rss)
      expect(current_path).to eq(feed_path(format: :atom))
    end
  end
end
