class Training < ApplicationRecord
  belongs_to :user
  belongs_to :playlist

  validates :average_speed, presence: true
  validates :training_duration, presence: true
  validates :music_genre, presence: true, inclusion: { in: Music::MUSIC_GENRE }
  validates :name, presence: true
end
