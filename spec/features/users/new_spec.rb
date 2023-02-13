# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'register page' do
  it 'has a form with fields to fill in' do
    visit register_path
    expect(page).to have_field('Name')
    expect(page).to have_field('Email')
    expect(page).to have_button('Create New User')
  end

  it 'takes user to new dashboard page where :id is id for new user created' do
    user1 = User.create!(name: 'Dennis Franz', email: 'dennis@aol.com', password: 'plaintxtpassword',
                         password_confirmation: 'plaintxtpassword')

    visit register_path

    fill_in 'Name', with: 'Teddy Bear'
    fill_in 'Email', with: 'ted@gmail.com'
    fill_in 'Password', with: 'pass1234'
    fill_in 'Password confirmation', with: 'pass1234'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(user1.id + 1))
    expect(page).to have_content('User Created Successfully')
  end

  it 'will take you back to register page if you fail to enter unique email' do
    User.create!(name: 'Jack Johnson', email: 'jack@mac.com', password: 'abcdefghi123',
                 password_confirmation: 'abcdefghi123')

    visit register_path

    fill_in 'Name', with: 'Teddy Bear'
    fill_in 'Email', with: 'jack@mac.com'
    fill_in 'Password', with: 'pass1234'
    fill_in 'Password confirmation', with: 'pass1234'
    click_button 'Create New User'

    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email can't be blank")
  end

  it 'requires name field' do
    visit register_path

    fill_in 'Email', with: 'jack@mac.com'
    fill_in 'Password', with: 'pass1234'
    fill_in 'Password confirmation', with: 'pass1234'
    click_button 'Create New User'

    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Name can't be blank")
  end

  it 'requires passwords to match' do
    visit register_path

    fill_in 'Name', with: 'Teddy Bear'
    fill_in 'Email', with: 'jack@mac.com'
    fill_in 'Password', with: 'pass1234'
    fill_in 'Password confirmation', with: 'pass4321'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
