class Game < ApplicationRecord
  belongs_to :word
  has_many :guesses

  BEGINNING_GUESSES = 6

  validates :word, presence: true
end
