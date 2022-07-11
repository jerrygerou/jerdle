class Guess < ApplicationRecord
  belongs_to :game
  has_one :word, through: :game

  SPACES = (0..4).to_a

  def is_the_same_word?
    word.body.match?(body)
  end

  def has_some_matching_letters?
    matching_letters = []
    word_body_array.each { |val| matching_letters << val if guess_body_array.include?(val) }
    !matching_letters.nil?
  end

  def matching_letters
    matching_letters = {}
    word_body_array.each_with_index { |val, index| matching_letters[index] = val.downcase if (guess_body_array.include?(val) && guess_body_array[index] != val) }
    matching_letters
  end

  def matching_indexes
    matching_indexes = {}
    word_body_array.each_with_index { |val, index| matching_indexes[index] = val.upcase if guess_body_array[index] == val }
    matching_indexes
  end

  def insert_blanks(matching_letters, matching_indexes)
    string_to_return = ""
    combined_hash = matching_indexes.merge(matching_letters)
    SPACES.each { |i| combined_hash[i] = "_" if combined_hash[i].nil?}
    combined_hash.keys.sort.each { |key| string_to_return += "#{combined_hash[key]}" }
    string_to_return
  end

  private

  def word_body_array
    word.body.downcase.split(//)
  end

  def guess_body_array
    body.downcase.split(//)
  end
end
