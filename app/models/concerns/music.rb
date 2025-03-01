class Music < ApplicationRecord
  belongs_to :playlist

  validates :content, presence: true
end
