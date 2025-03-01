require "open-uri"

User.destroy_all
user1 = User.new(email: "sasha@runify.com", password: "123456", password_confirmation: "123456")
user1.save!
user2 = User.new(email: "meven@runify.com", password: "123456", password_confirmation: "123456")
user2.save!
user3 = User.new(email: "aurelie@runify.com", password: "123456", password_confirmation: "123456")
user3.save!


Playlist.destroy_all
playlist1 = Playlist.new(name: "Rap dynamique")
playlist1.save!
playlist2 = Playlist.new(name: "Rock dynamique")
playlist2.save!



Music.destroy_all
music1 = Music.new(title: "Kiai", genre: "rap", duration: "130", bpm: "140", playlist_id: playlist1.id)
music1.save!
music2 = Music.new(title: "Kokk", genre: "rap", duration: "176", bpm: "90", playlist_id:  playlist1.id)
music2.save!
music3 = Music.new(title: "ppop", genre: "rock", duration: "140", bpm: "100", playlist_id:  playlist2.id)
music3.save!


Training.destroy_all
training1 = Training.new(average_speed: "10", training_duration: "150", music_genre: "rap", name: "Rap training", user_id: User.last.id, playlist_id: playlist1.id)
training1.save!
training2 = Training.new(average_speed: "20", training_duration: "100", music_genre: "rap", name: "rap training 2", user_id: User.last.id, playlist_id: playlist1.id)
training2.save!
training3 = Training.new(average_speed: "15", training_duration: "250", music_genre: "rock", name: "rock training", user_id: User.last.id, playlist_id: playlist2.id)
training3.save!
