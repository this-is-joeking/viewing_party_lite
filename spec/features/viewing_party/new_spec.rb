# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'new viewing party page', :vcr do
  describe 'new vp page if logged in' do
    before(:each) do
      @user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                            password_confirmation: 'plaintxtpassword')
      @user2 = User.create!(name: 'John Smith', email: 'johndoe@gmail.com', password: 'plaintxtpassword',
                            password_confirmation: 'plaintxtpassword')
      @user3 = User.create!(name: 'John Williams', email: 'johndoe@email.com', password: 'plaintxtpassword',
                            password_confirmation: 'plaintxtpassword')
      @user4 = User.create!(name: 'John Kennedy', email: 'johndoe@webmail.com', password: 'plaintxtpassword',
                            password_confirmation: 'plaintxtpassword')
      @user5 = User.create!(name: 'John Deere', email: 'johndoe@mail.com', password: 'plaintxtpassword',
                            password_confirmation: 'plaintxtpassword')
      @movie = MovieFacade.movie_details(238)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end

    it 'displays the movie title for the new viewing party' do
      visit new_movie_viewing_party_path(@movie.id)

      expect(page).to have_content('Create a Movie Party for The Godfather')
    end

    it 'has a link back to the discover page' do
      visit new_movie_viewing_party_path(@movie.id)

      expect(page).to have_link('Discover Page', href: discover_index_path)
    end

    it 'has a form to enter details for user party and duration defaults to movies runtime' do
      visit new_movie_viewing_party_path(@movie.id)
      users = [@user2, @user3, @user4, @user5]

      within '#party-details' do
        expect(page).to have_content('The Godfather')
        expect(page).to have_field('Duration of Party', with: @movie.runtime)
        expect(page).to have_field('Day')
        expect(page).to have_field('Start Time')
        expect(page).to have_button('Create Party')
        users.each do |user|
          expect(page).to have_content(user.name)
          expect(page).to have_content(user.email)
        end
        expect(page).to_not have_content(@user1.name)
      end
    end

    it 'creates a new viewing party and viewing party users when you complete form with valid data' do
      visit new_movie_viewing_party_path(@movie.id)

      fill_in 'Duration of Party', with: '200'
      fill_in 'Day', with: '%03.%02.%2023'
      fill_in 'Start Time', with: '08:00 PM'

      check(@user2.name.to_s)
      check(@user3.name.to_s)
      click_button 'Create Party'

      expect(current_path).to eq(dashboard_path)
      within "#viewing_party#{ViewingParty.maximum(:id)}" do
        expect(page).to have_content('February 03, 2023')
        expect(page).to have_content('Hosting John Smith John Williams')
        expect(page).to have_content('8:00 pm')
        expect(page).to have_content(@movie.title)
      end
    end

    it 'does not create a viewing party if you enter invalid data' do
      visit new_movie_viewing_party_path(@movie.id)

      fill_in 'Duration of Party', with: '200'
      fill_in 'Day', with: '%03.%02.%2023'
      check(@user2.name.to_s)
      check(@user3.name.to_s)
      click_button 'Create Party'

      expect(current_path).to eq(new_movie_viewing_party_path(@movie.id))
      expect(page).to have_content("Start time can't be blank")
    end
  end

  it 'requires login to create a viewing party' do
    @movie = MovieFacade.movie_details(238)

    visit movie_path(@movie.id)
    click_link 'Create Viewing Party for The Godfather'

    expect(current_path).to eq(movie_path(@movie.id))
    expect(page).to have_content('You must be logged in / registered to create a movie party')
  end
end
