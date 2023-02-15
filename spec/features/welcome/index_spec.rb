# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Landing Page' do
  it 'shows title of app, button to create a user, and link to login' do
    visit root_path

    expect(page).to have_content('Viewing Party')
    expect(page).to have_button('Create an account')
    expect(page).to have_button('Log In')
  end

  it 'lists existing users with links to user dashboard' do
    User.create!(name: 'John Doe', email: 'john@doe.com', password: 'plaintxtpassword',
                 password_confirmation: 'plaintxtpassword')
    User.create!(name: 'Jane Smith', email: 'jane@gmail.com', password: 'plaintxtpassword',
                 password_confirmation: 'plaintxtpassword')

    visit login_path

    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Password', with: 'plaintxtpassword'

    click_on 'Log in'

    visit root_path

    expect(page).to have_content('Existing Users:')

    within '#existing_users' do
      expect(page).to have_content('john@doe.com')
      expect(page).to have_content('jane@gmail.com')
    end
  end

  it 'has a link to the landing page' do
    visit root_path

    expect(page).to have_link('Home', href: root_path)
  end
end
