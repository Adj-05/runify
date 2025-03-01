require "open-uri"

User.destroy_all
user1 = User.new(email: "sasha@runify.com", password: "123456", password_confirmation: "123456")
user1.save!
user2 = User.new(email: "meven@runify.com", password: "123456", password_confirmation: "123456")
user2.save!
user3 = User.new(email: "aurelie@runify.com", password: "123456", password_confirmation: "123456")
user3.save!


Music.destroy_all
music1 = Music.new(genre: "Rap", duration: "1min30", bpm: "140bpm")
music1.save!
music2 = Music.new(genre: "Rock", duration: "1min43", bpm: "90bpm")
music2.save!
music3 = Music.new(genre: "Pop", duration: "2min20", bpm: "100bpm")
music3.save!


Training.destroy_all
training1 = Training.new(average_speed: "10km/h", training_duration: "15min", music_genre: "Rap", name: "Rap training", user_id: User.last.id)
training1.save!
training2 = Training.new(average_speed: "20km/h", training_duration: "10min", music_genre: "Rock", name: "Rock training", user_id: User.last.id)
training2.save!
training3 = Training.new(average_speed: "15km/h", training_duration: "25min", music_genre: "Pop", name: "Pop training", user_id: User.last.id)
training3.save!


Playlist.destroy_all
playlist1 = Playlist.new(favorite: "true")
playlist1.save!
