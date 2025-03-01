class Training < ApplicationRecord
  belongs_to :user
  belongs_to :playlist

  validates :average_speed, presence: true
  validates :training_duration, presence: true
  validates :music_genre, presence: true, inclusion: { in: Music::MUSIC_GENRE }
  validates :name, presence: true

  before_validation :generate_training_name, only: [:create]

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

end
