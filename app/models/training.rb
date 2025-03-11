class Training < ApplicationRecord
  belongs_to :user
  has_many :playlists

  AVERAGE_SPEED = ["Slow : 7.1 to 8.3 mins/KM", "Medium : 5.3 to 6.5 mins/KM", "Fast : 4 to 5.1 mins/KM"]

  TRAINING_DURATION = ["10", "20", "30", "45", "60", "90", "120"]

  validates :average_speed, presence: true, inclusion: { in: AVERAGE_SPEED }
  validates :training_duration, presence: true, inclusion: { in: TRAINING_DURATION }
  validates :music_genre, presence: true, inclusion: { in: Music::MUSIC_GENRE }
  validates :name, presence: true

  # before_validation :generate_training_name, only: [:create]

  # before_validation :generate_playlist

  def generate_training_name
    # Donne l'heure sous forme entier arrondi inferieur
    if Time.now.hour > 0 && Time.now.hour < 12
      self.name = "Morning Run"
    elsif Time.now.hour > 11 && Time.now.hour < 18
      self.name = "Afternoon Run"
    else
      self.name = "Evening Run"
    end
  end

  def generate_playlist
    case average_speed
    when 'slow'
      bpm_min = 100
      bpm_max = 120
    when 'medium'
      bpm_min = 121
      bpm_max = 140
    when 'fast'
      bpm_min = 141
      bpm_max = 160
    end

    results = RSpotify::Recommendations.generate(
      min_tempo: bpm_min,
      max_tempo: bpm_max,
      seed_genres: [music_genre]
    )

    tracks = []
    total_duration = 0

    debugger

    results.tracks.each do |track|
      break if total_duration >= training_duration

      tracks << track.uri
      total_duration += track.duration_ms / 1000 # Convertit en secondes
    end
  end
end
