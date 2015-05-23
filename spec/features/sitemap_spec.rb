require 'rails_helper'

feature 'Sitemap' do
  let!(:current) { create(:location, current: true) }
  let!(:post) { create(:post) }
  let!(:experience) { create(:experience) }

  scenario 'works' do
    expect{ visit "/sitemap.xml" }.to_not raise_error
  end
end
