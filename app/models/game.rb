class Game < ApplicationRecord
  belongs_to :word
  has_many :guesses
  accepts_nested_attributes_for :guesses

  validates :word, presence: true
end
