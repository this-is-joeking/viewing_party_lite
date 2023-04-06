# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie results page', :vcr do
  before(:each) do
    @user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                          password_confirmation: 'plaintxtpassword')
  end

  it 'lists top 20 rated movies when user clicks find top rated movies from dash' do
    visit discover_index_path

    expect(page).to have_link('Find Top Rated Movies', href: '/movies?q=top%20rated')

    click_link 'Find Top Rated Movies'

    expect(page).to have_content('The Godfather 8.7')
    expect(page).to have_content('The Shawshank Redemption 8.7')
    expect(page).to have_content('The Godfather Part II 8.6')
  end

  it 'populates relevant results given a keyword search from dashboard' do
    visit discover_index_path

    fill_in('q', with: 'The Matrix')
    click_on('Find Movies')

    expect(current_path).to eq(movies_path)
    expect(page).to have_content('The Matrix 8.2 The Matrix Resurrections 6.536')
  end

  it 'has a link back to the discover page' do
    visit '/movies?q=top%20rated'

    expect(page).to have_link('Discover Page', href: discover_index_path)
  end

  it 'links each movie to that leads to the movie details page' do
    visit '/movies?q=top%20rated'

    expect(page).to have_link('The Godfather', href: movie_path(238))
    expect(page).to have_link('The Shawshank Redemption', href: movie_path(278))
  end
end
