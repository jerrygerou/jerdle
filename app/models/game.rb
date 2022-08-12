class Game < ApplicationRecord
  belongs_to :word
  has_many :guesses
  accepts_nested_attributes_for :guesses

  validates :word, presence: true

  def game_won?
    if guesses.present?
      guesses.last.body.downcase.match?(word.body.downcase)
    else
      false
    end
  end

  def game_over?
    if guesses.count >= Guess::BEGINNING_GUESSES
    elsif guesses.map {|guess| word.body.downcase.match?(guess.body.downcase) }
    else
      false
    end
  end
end
