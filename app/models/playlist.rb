class Playlist < ApplicationRecord
  has_many :musics
  has_many :trainings
end
