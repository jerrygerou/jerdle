class Guess < ApplicationRecord

  belongs_to :game
  has_one :word, through: :game

  class InvalidWordError < StandardError; end

  SPACES = (0..4).to_a

  def is_correct?
    word.body.downcase.match?(body.downcase)
  end

  def guess_response
    raise InvalidWordError, "Word does not exist" unless valid_guess?

    string_response = ""
    SPACES.each { |i| combined_hash[i] = "_" if combined_hash[i].nil?}
    combined_hash.keys.sort.each { |key| string_response += "#{combined_hash[key]}" }
    string_response
  end

  private

  def valid_guess?
    Word.find_by(body: body).present?
  end

  def word_body_array
    word.body.downcase.split(//)
  end

  def guess_body_array
    body.downcase.split(//)
  end

  def combined_hash
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
