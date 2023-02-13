require 'rails_helper'

RSpec.describe 'user login page' do
  it 'lets a user login with correct username and password' do
    user = User.create!(name: 'Jack Johnson', email: 'jack@mac.com', password: 'abcdefghi123', password_confirmation: 'abcdefghi123')

    visit login_path

    fill_in 'Email', with: 'jack@mac.com'
    fill_in 'Password', with: 'abcdefghi123'
    click_button 'Log in'

    expect(current_path).to eq(user_path(user))
  end

  it 'does not login an flashes error if not passed correct email/password combo' do
    user = User.create!(name: 'Jack Johnson', email: 'jack@mac.com', password: 'abcdefghi123', password_confirmation: 'abcdefghi123')

    visit login_path

    fill_in 'Email', with: 'jack@mac.com'
    fill_in 'Password', with: 'wrong password'
    click_button 'Log in'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Could not find user with that password email combo, try again or register')
  end

  it 'does not login and provides error if email is not registered' do
    visit login_path

    fill_in 'Email', with: 'jack@mac.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Could not find user with that password email combo, try again or register')
  end

  it 'is case insensitive for email addresses' do
    user = User.create!(name: 'Jack Johnson', email: 'JACK@mac.com', password: 'abcdefghi123', password_confirmation: 'abcdefghi123')

    visit login_path

    fill_in 'Email', with: 'jack@MAC.com'
    fill_in 'Password', with: 'abcdefghi123'
    click_button 'Log in'

    expect(current_path).to eq(user_path(user))
  end
end