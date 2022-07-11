class Game < ApplicationRecord
  belongs_to :word
  has_many :guesses

  validates :word, presence: true
end
