class Playlist < ApplicationRecord
  has_many :musics
  belongs_to :training
end
