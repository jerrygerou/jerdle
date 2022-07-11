class Word < ApplicationRecord
  validates :body, presence: true, length: { is: 5 }
  has_many :games
  has_many :guesses, through: :games
end
