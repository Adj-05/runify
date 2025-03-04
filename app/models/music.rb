class Music < ApplicationRecord
  belongs_to :playlist

  MUSIC_GENRE = ["rap", "rock", "pop", "reggae"]

  validates :genre, presence: true, inclusion: { in: MUSIC_GENRE }
  validates :duration, presence: true
  validates :bpm, presence: true

end
