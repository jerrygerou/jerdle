class Guess < ApplicationRecord
  belongs_to :game
  has_one :word, through: :game

  validates :body, presence: true, length: { is: 5 }
  validate :valid_guess?
  validate :more_guesses_available?

  BEGINNING_GUESSES = 6

  class InvalidWordError < StandardError; end

  SPACES = (0..4).to_a

  def guess_response
    string_response = ""
    combined_hash = matching_indexes_and_letters
    SPACES.each { |i| combined_hash[i] = "_" if combined_hash[i].nil?}
    combined_hash.keys.sort.each { |key| string_response += "#{combined_hash[key]}" }
    string_response
  end

  def is_correct?
    word.body.downcase.match?(body.downcase)
  end

  private

  def more_guesses_available?
    game = Game.find(game_id)
    guesses_count = game.guesses.count
    if guesses_count >= BEGINNING_GUESSES
      errors.add(:game_over, "Out of guesses! You lose!")
    end
  end

  def valid_guess?
    unless Word.find_by(body: body).present?
      errors.add(:invalid_word, "Word does not exist in word list")
    end
  end

  def word_body_array
    word.body.downcase.split(//)
  end

  def guess_body_array
    body.downcase.split(//)
  end

  def matching_indexes_and_letters
    matching_indexes.merge(matching_letters)
  end

  def matching_letters
    matching_letters = {}
    guess_body_array.each_with_index { |val, index| matching_letters[index] = val.downcase if (word_body_array.include?(val) && word_body_array[index] != val) }
    matching_letters.reject! {|key, value| matching_indexes.has_value?(value.upcase) }
    matching_letters
  end

  def matching_indexes
    matching_indexes = {}
    guess_body_array.each_with_index { |val, index| matching_indexes[index] = val.upcase if word_body_array[index] == val }
    matching_indexes
  end
end
