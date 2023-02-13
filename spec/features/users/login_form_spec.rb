require 'rails_helper'

RSpec.describe 'user login page' do
  it 'has a form for user to enter email and password' do
    visit login_path

    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
  end
  
end