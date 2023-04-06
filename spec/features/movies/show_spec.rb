# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'movie details page', :vcr do
  before(:each) do
    @user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                          password_confirmation: 'plaintxtpassword')
  end

  it 'has a link back to the discover page' do
    visit movie_path(238)

    expect(page).to have_link('Discover Page', href: discover_index_path)
  end

  it 'has a button to create a viewing party' do
    visit movie_path(238)

    expect(page).to have_link('Create Viewing Party for The Godfather',
                              href: new_movie_viewing_party_path(238))
  end

  it 'has the average vote, runtime and genres' do
    visit movie_path(238)

    expect(page).to have_content('Vote: 8.712 Runtime: 2hr 55min Genre(s): Drama and Crime')
  end

  it 'lists the summary' do
    visit movie_path(238)

    expect(page).to have_content('Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.')
  end

  it 'lists the top 10 credited actors and their character name' do
    visit movie_path(238)

    expect(page).to have_content('Marlon Brando as Vito Corleone, Al Pacino as Michael Corleone, James Caan as Sonny Corleone, Richard S. Castellano as Peter Clemenza, Robert Duvall as Tom Hagen, Sterling Hayden as Captain McCluskey, John Marley as Jack Woltz, Richard Conte as Emilio Barzini, Diane Keaton as Kay Adams-Corleone, and Talia Shire as Connie Corleone')
    expect(page).to_not have_content('Abe Vigoda')
  end

  it 'lists count of reviews and all reviews with an author' do
    visit movie_path(238)

    expect(page).to have_content('3 Reviews')
    expect(page).to have_content("Review by: crastana Rating: 10.0/10.0 The best movie ever...\r A masterpiece by the young and talented Francis Ford Coppola, about a Mob family and their drama, the story telling is perfect, the acting good, sometimes a little over the top in the case of Thalia Shire (the sister of the director)\r \r The 70's were the best years for Hollywood.")
  end
end
