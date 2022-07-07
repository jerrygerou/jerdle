class Game < ApplicationRecord
  has_one :word
  has_many :guesses


end
