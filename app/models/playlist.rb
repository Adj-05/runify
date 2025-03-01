class Playlist < ApplicationRecord
  has_many :musics, dependent: :destroy
  belongs_to :training

  validates :content, presence: true
end
