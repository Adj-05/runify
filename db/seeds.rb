require "open-uri"

p "destroying all users"
User.destroy_all
p "users destroyed"

p "destroying all playlists"
Playlist.destroy_all
p "playlists destroyed"

p "destroying all musics"
Music.destroy_all
p "musics destroyed"

p "destroying all trrainings"
Training.destroy_all
p "trainings destroyed"

p "creating users"
user1 = User.new(email: "sasha@runify.com", password: "123456", password_confirmation: "123456")
user1.save!
user2 = User.new(email: "meven@runify.com", password: "123456", password_confirmation: "123456")
user2.save!
user3 = User.new(email: "aurelie@runify.com", password: "123456", password_confirmation: "123456")
user3.save!
p "users created"

p "creating trainings"
Training.destroy_all
training1 = Training.new(
  average_speed: "10",
  training_duration: "150",
  music_genre: "rap",
  name: "Rap training",
  user_id: User.last.id,
)
training1.save!

training2 = Training.new(
  average_speed: "20",
  training_duration: "100",
  music_genre: "rap",
  name: "rap training 2",
  user_id: User.last.id,
)
training2.save!

training3 = Training.new(
  average_speed: "15",
  training_duration: "250",
  music_genre: "rock",
  name: "rock training",
  user_id: User.last.id,
)
training3.save!
p "trainings created"

p "creating playlists"
playlist1 = Playlist.new(name: "Rap dynamique", training: training1)
playlist1.save!
playlist2 = Playlist.new(name: "Rock dynamique", training: training2)
playlist2.save!
p "playlists created"

p "creating musics"
music1 = Music.new(title: "Bolide allemand", genre: "rap", duration: 176, bpm: 132, playlist_id: playlist1.id)
music1.save!
music2 = Music.new(title: "Meuda", genre: "rap", duration: 152, bpm: 142, playlist_id: playlist1.id)
music2.save!
music3 = Music.new(title: "Demain", genre: "rap", duration: 183, bpm: 138, playlist_id: playlist1.id)
music3.save!
music4 = Music.new(title: "Jolie", genre: "rap", duration: 159, bpm: 134, playlist_id: playlist1.id)
music4.save!
music5 = Music.new(title: "ARIZONA", genre: "rap", duration: 160, bpm: 120, playlist_id: playlist1.id)
music5.save!
music6 = Music.new(title: "LA RUE", genre: "rap", duration: 225, bpm: 138, playlist_id: playlist1.id)
music6.save!
music7 = Music.new(title: "Nouvelles", genre: "rap", duration: 179, bpm: 196, playlist_id: playlist1.id)
music7.save!
music8 = Music.new(title: "TP", genre: "rap", duration: 178, bpm: 103, playlist_id: playlist1.id)
music8.save!
music9 = Music.new(title: "Triste", genre: "rap", duration: 135, bpm: 142, playlist_id: playlist1.id)
music9.save!
music10 = Music.new(title: "Laboratoire", genre: "rap", duration: 162, bpm: 125, playlist_id: playlist1.id)
music10.save!
music11 = Music.new(title: "Finale - Nouvelle École", genre: "rap", duration: 180, bpm: 144, playlist_id: playlist1.id)
music11.save!
music12 = Music.new(title: "25 G", genre: "rap", duration: 250, bpm: 137, playlist_id: playlist1.id)
music12.save!
music13 = Music.new(title: "M'en sortir", genre: "rap", duration: 210, bpm: 140, playlist_id: playlist1.id)
music13.save!
music14 = Music.new(title: "Piranha", genre: "rap", duration: 155, bpm: 95, playlist_id: playlist1.id)
music14.save!
music15 = Music.new(title: "Khemem", genre: "rap", duration: 175, bpm: 134, playlist_id: playlist1.id)
music15.save!
music16 = Music.new(title: "DIE", genre: "rap", duration: 240, bpm: 131, playlist_id: playlist1.id)
music16.save!
music17 = Music.new(title: "DOSSIDOS", genre: "rap", duration: 145, bpm: 132, playlist_id: playlist1.id)
music17.save!
music18 = Music.new(title: "TOUT VA BIEN", genre: "rap", duration: 192, bpm: 100, playlist_id: playlist1.id)
music18.save!
music19 = Music.new(title: "Mona Lisa", genre: "rap", duration: 187, bpm: 134, playlist_id: playlist1.id)
music19.save!
music20 = Music.new(title: "AMBER", genre: "rap", duration: 182, bpm: 141, playlist_id: playlist1.id)
music20.save!
music21 = Music.new(title: "Are You Gonna Be My Girl", genre: "rock", duration: 213, bpm: 104, playlist_id: playlist2.id)
music21.save!
music22 = Music.new(title: "Can't Stop", genre: "rock", duration: 269, bpm: 91, playlist_id: playlist2.id)
music22.save!
music23 = Music.new(title: "One Step Closer", genre: "rock", duration: 155, bpm: 95, playlist_id: playlist2.id)
music23.save!
music24 = Music.new(title: "Shotgun Blues", genre: "rock", duration: 200, bpm: 95, playlist_id: playlist2.id)
music24.save!
music25 = Music.new(title: "Break Stuff", genre: "rock", duration: 167, bpm: 94, playlist_id: playlist2.id)
music25.save!
music26 = Music.new(title: "Beyond", genre: "rock", duration: 255, bpm: 92, playlist_id: playlist2.id)
music26.save!
music27 = Music.new(title: "Runnin' Wild", genre: "rock", duration: 218, bpm: 165, playlist_id: playlist2.id)
music27.save!
music28 = Music.new(title: "Doctor Alibi", genre: "rock", duration: 190, bpm: 160, playlist_id: playlist2.id)
music28.save!
music29 = Music.new(title: "You Are the Young", genre: "rock", duration: 225, bpm: 162, playlist_id: playlist2.id)
music29.save!
music30 = Music.new(title: "Jerk", genre: "rock", duration: 237, bpm: 168, playlist_id: playlist2.id)
music30.save!
music31 = Music.new(title: "Terrifying", genre: "rock", duration: 293, bpm: 143, playlist_id: playlist2.id)
music31.save!
music32 = Music.new(title: "Are You Gonna Be My Girl", genre: "rock", duration: 373, bpm: 140, playlist_id: playlist2.id)
music32.save!
music33 = Music.new(title: "Keep on Loving You", genre: "rock", duration: 312, bpm: 140, playlist_id: playlist2.id)
music33.save!
music34 = Music.new(title: "Venus", genre: "rock", duration: 240, bpm: 140, playlist_id: playlist2.id)
music34.save!
music35 = Music.new(title: "Shoot to Thrill", genre: "rock", duration: 322, bpm: 142, playlist_id: playlist2.id)
music35.save!
music36 = Music.new(title: "Word Up", genre: "rock", duration: 254, bpm: 124, playlist_id: playlist2.id)
music36.save!
music37 = Music.new(title: "Billie Jean", genre: "rock", duration: 294, bpm: 118, playlist_id: playlist2.id)
music37.save!
music38 = Music.new(title: "Get Lucky", genre: "rock", duration: 369, bpm: 116, playlist_id: playlist2.id)
music38.save!
music39 = Music.new(title: "Whenever, Wherever", genre: "rock", duration: 196, bpm: 141, playlist_id: playlist2.id)
music39.save!
music40 = Music.new(title: "Dilemma", genre: "rock", duration: 289, bpm: 85, playlist_id: playlist2.id)
music40.save!
p "mucis created"
