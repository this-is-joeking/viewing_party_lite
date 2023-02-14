# frozen_string_literal: true

@user1 = User.create!(name: 'John Doe', email: 'johndoe@ymail.com', password: 'plaintxtpassword',
                      password_confirmation: 'plaintxtpassword')
@user2 = User.create!(name: 'Exene Cervenka', email: 'exene@hotmail.com', password: 'plaintxtpassword',
                      password_confirmation: 'plaintxtpassword')
@user3 = User.create!(name: 'Billy Zoom', email: 'zoomies@aol.com', password: 'plaintxtpassword1',
                      password_confirmation: 'plaintxtpassword1')
@user4 = User.create!(name: 'DJ Bonebreak', email: 'djb@yahoo.com', password: 'plaintxtpassword2',
                      password_confirmation: 'plaintxtpassword2')
@user5 = User.create!(name: 'Bob Sagat', email: 'bobbys@gmail.com', password: 'plaintxtpassword',
                      password_confirmation: 'plaintxtpassword')
@user6 = User.create!(name: 'Don Letts', email: 'lettsgymail.com', password: 'plaintxtpassword',
                      password_confirmation: 'plaintxtpassword')
@user7 = User.create!(name: 'Siouxsie Sioux', email: 'siouxsie@thebanshees.com', password: 'plaintxtpassword',
                      password_confirmation: 'plaintxtpassword')
@user8 = User.create!(name: 'Genesis P. Orridge', email: 'psychictv@.throbbinggristlecom', password: 'plaintxtpassword',
                      password_confirmation: 'plaintxtpassword')
@user9 = User.create!(name: 'Simon Gallup', email: 'simon@thecure.com', password: 'plaintxtpassword',
                      password_confirmation: 'plaintxtpassword')
@user10 = User.create!(name: 'Jere Lehmus', email: 'jerelehmus.gmail.com', password: 'plaintxtpassword',
                       password_confirmation: 'plaintxtpassword')
@user11 = User.create!(name: 'Danny Elfman', email: 'elfman@hotmail.com', password: 'plaintxtpassword',
                       password_confirmation: 'plaintxtpassword')
@user12 = User.create!(name: 'Lemmy Kilmister', email: 'thekingofkings@motorhead.com', password: 'plaintxtpassword',
                       password_confirmation: 'plaintxtpassword')

@admin1 = User.create!(name: 'Admin', email: 'admin@admin.com', password: 'admin1',
                       password_confirmation: 'admin1', role: 1)

@vp1 = ViewingParty.create!(movie_id: 90_652, date: 'Mon, 30 Jan 2023', party_duration: 118,
                            start_time: Time.parse('19:00:00 UTC'))
@vp2 = ViewingParty.create!(movie_id: 21_137, date: 'Tue, 31 Jan 2023', party_duration: 95,
                            start_time: Time.parse('20:00:00 UTC'))
@vp3 = ViewingParty.create!(movie_id: 48_677, date: 'Fri, 10 Feb 2023', party_duration: 300,
                            start_time: Time.parse('17:30:00 UTC'))
@vp4 = ViewingParty.create!(movie_id: 14_577, date: 'Tue, 28 Feb 2023', party_duration: 154,
                            start_time: Time.parse('20:00:00 UTC'))

@vpu1 = @user1.viewing_party_users.create!(viewing_party_id: @vp1.id, hosting: true)
@vpu2 = @user2.viewing_party_users.create!(viewing_party_id: @vp2.id, hosting: true)
@vpu3 = @user3.viewing_party_users.create!(viewing_party_id: @vp3.id, hosting: true)
@vpu4 = @user4.viewing_party_users.create!(viewing_party_id: @vp4.id, hosting: true)
@vpu5 = @user1.viewing_party_users.create!(viewing_party_id: @vp4.id, hosting: false)
@vpu6 = @user2.viewing_party_users.create!(viewing_party_id: @vp1.id, hosting: false)
@vpu7 = @user3.viewing_party_users.create!(viewing_party_id: @vp1.id, hosting: false)
@vpu8 = @user4.viewing_party_users.create!(viewing_party_id: @vp2.id, hosting: false)
@vpu9 = @user1.viewing_party_users.create!(viewing_party_id: @vp2.id, hosting: false)
@vpu10 = @user5.viewing_party_users.create!(viewing_party_id: @vp2.id, hosting: false)
@vpu11 = @user12.viewing_party_users.create!(viewing_party_id: @vp2.id, hosting: false)
@vpu12 = @user6.viewing_party_users.create!(viewing_party_id: @vp2.id, hosting: false)
@vpu13 = @user10.viewing_party_users.create!(viewing_party_id: @vp3.id, hosting: false)
@vpu14 = @user2.viewing_party_users.create!(viewing_party_id: @vp3.id, hosting: false)
@vpu15 = @user9.viewing_party_users.create!(viewing_party_id: @vp1.id, hosting: false)
@vpu16 = @user7.viewing_party_users.create!(viewing_party_id: @vp4.id, hosting: false)
@vpu17 = @user8.viewing_party_users.create!(viewing_party_id: @vp4.id, hosting: false)
@vpu18 = @user2.viewing_party_users.create!(viewing_party_id: @vp4.id, hosting: false)
