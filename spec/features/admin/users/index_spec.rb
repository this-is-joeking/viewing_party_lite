# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin dashboard page', :vcr do
  before(:each) do
    @user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                          password_confirmation: 'plaintxtpassword')
    @user2 = User.create!(name: 'Exene Cervenka', email: 'exene@hotmail.com', password: 'plaintxtpassword',
                          password_confirmation: 'plaintxtpassword')

    @admin1 = User.create!(name: 'Admin', email: 'admin@admin.com', password: 'admin1',
                           password_confirmation: 'admin1', role: 1)

    visit login_path
    fill_in 'Email', with: 'admin@admin.com'
    fill_in 'Password', with: 'admin1'

    click_on 'Log in'
  end

  it 'directs to the admin dash at login' do
    expect(current_path).to eq(admin_dashboard_path)
  end

  it 'has links to each users dashboard, admin emails are not shown' do
    vp1 = ViewingParty.create!(movie_id: 238, date: 'Mon, 30 Jan 2023', party_duration: 118,
                               start_time: Time.parse('19:00:00 UTC'))
    @user1.viewing_party_users.create!(viewing_party_id: vp1.id, hosting: true)

    expect(page).to have_link(@user1.email)
    expect(page).to have_link(@user2.email)
    expect(page).to_not have_link(@admin1.email)

    click_link(@user1.email)

    expect(current_path).to eq(admin_user_path(@user1))
  end

  it 'cannot be accessed by visitors or default users' do
    click_link 'Log Out'

    visit admin_dashboard_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You are not authorized to access that page')
  end
end
