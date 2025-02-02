# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'discover movies page', :vcr do
  before(:each) do
    @user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                          password_confirmation: 'plaintxtpassword')
  end

  it 'has a button to discover top rated movies that leads to top 20 rated movies' do
    visit discover_index_path

    expect(page).to have_link('Top Rated Movies')

    click_link 'Top Rated Movies'
    expect(current_path).to eq(movies_path)
  end

  it 'has a button trending movies this week that leads to trending movies' do
    visit discover_index_path

    expect(page).to have_link('Trending Movies This Week')

    click_link 'Trending Movies This Week'
    expect(current_path).to eq(movies_path)
  end

  it 'has a button trending movies this week that leads to different trending movies' do
    visit discover_index_path

    expect(page).to have_link('Trending Movies Today')

    click_link 'Trending Movies Today'
    expect(current_path).to eq(movies_path)
  end

  it 'has a search field to find movies by title' do
    visit discover_index_path

    fill_in('q', with: 'The Matrix')
    click_on('Search')

    expect(current_path).to eq(movies_path)
  end
end
