# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'relationships' do
    it { should have_many :viewing_party_users }
    it { should have_many(:viewing_parties).through(:viewing_party_users) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of :password_digest }
    it { should have_secure_password }
  end

  describe 'authentication' do
    it 'should not save a passwords plaintext' do
      user = User.create!(name: 'Sawson', email: 'dangshawty@hotmail.com', password: 'plaintxtpassword',
                          password_confirmation: 'plaintxtpassword')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('plaintxtpassword')
    end
  end

  describe 'default role' do 
    it 'should set default role to user' do
      user = User.create!(name: 'Sawson', email: 'dangshawty@hotmail.com', password: 'plaintxtpassword',
        password_confirmation: 'plaintxtpassword')

      expect(user.role).to eq('default')
    end

    it 'allows admins to be created' do
      user = User.create!(name: 'Sawson', email: 'dangshawty@hotmail.com', password: 'plaintxtpassword',
        password_confirmation: 'plaintxtpassword', role: 1)

      expect(user.role).to eq('admin')
    end
  end

  describe '#find_viewing_party_user()' do
    it 'returns the viewing party user for the given viewing party' do
      user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                           password_confirmation: 'plaintxtpassword')
      vp1 = ViewingParty.create!(movie_id: 1, date: 'Mon, 30 Jan 2023', party_duration: 118,
                                 start_time: Time.parse('19:00:00 UTC'))
      vp2 = ViewingParty.create!(movie_id: 2, date: 'Tue, 31 Jan 2023', party_duration: 95,
                                 start_time: Time.parse('20:00:00 UTC'))
      vpu1 = user1.viewing_party_users.create!(viewing_party_id: vp1.id, hosting: true)
      vpu2 = user1.viewing_party_users.create!(viewing_party_id: vp2.id, hosting: false)

      expect(user1.find_viewing_party_user(vp1)).to eq(vpu1)
      expect(user1.find_viewing_party_user(vp2)).to eq(vpu2)
    end
  end

  describe '#name_and_email' do
    it 'returns a string of users name and email' do
      user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                           password_confirmation: 'plaintxtpassword')
      user2 = User.create!(name: 'Scott Smith', email: 'test@email.com', password: 'plaintxtpassword',
                           password_confirmation: 'plaintxtpassword')

      expect(user1.name_and_email).to eq('John Doe (johndoe@ymail.com)')
      expect(user2.name_and_email).to eq('Scott Smith (test@email.com)')
    end
  end

  describe '#all_other_users' do
    it 'returns a collection of all other suers besides the one this is called on' do
      user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                           password_confirmation: 'plaintxtpassword')
      user2 = User.create!(name: 'Scott Smith', email: 'test@email.com', password: 'plaintxtpassword',
                           password_confirmation: 'plaintxtpassword')
      user3 = User.create!(name: 'Jack Johnson', email: 'jack@mac.com', password: 'plaintxtpassword',
                           password_confirmation: 'plaintxtpassword')
      user4 = User.create!(name: 'Willie Nelson', email: 'willie@email.com', password: 'plaintxtpassword',
                           password_confirmation: 'plaintxtpassword')

      expect(user1.all_other_users.sort).to eq([user2, user3, user4].sort)
      expect(user3.all_other_users.sort).to eq([user2, user1, user4].sort)
    end
  end
end
