require "test_helper"
require 'minitest/spec'

class GuessTest < ActiveSupport::TestCase
  def setup
    Word.create(body: "label")
    Word.create(body: "chart")
    Word.create(body: "camel")
  end

  test "guess will not create without a valid game associated" do
    guess = Guess.create(game: nil)

    assert_equal false, guess.valid?
    assert_equal guess.errors.messages, {:game=>["must exist"]}
  end

  test "guess will create with valid game associated" do
    word = Word.create(body: "mambo")
    game = Game.create(word: word)
    guess = Guess.create(game: game)

    assert_equal true, guess.valid?
  end

  test "#is_correct? returns true" do
    word = Word.create(body: "mambo")
    game = Game.create(word: word)
    guess = Guess.create(game: game, body: "mambo")
    guess2 = Guess.create(game: game, body: "MAmBO")

    assert_equal true, guess.is_correct?
    assert_equal true, guess2.is_correct?
  end

  test "#is_correct? returns false" do
    word = Word.create(body: "mambo")
    game = Game.create(word: word)
    guess = Guess.create(game: game, body: "hello")

    assert_equal false, guess.is_correct?
  end

  test "#guess_response? returns error for nonexistent word" do
    word = Word.create(body: "mambo")
    game = Game.create(word: word)
    guess = Guess.create(game: game, body: "helpe")

    assert_raises(Guess::InvalidWordError, "Word does not exist") { guess.guess_response }
  end

  test "#guess_response returns string with formatted response" do
    word = Word.find_by(body: "camel")
    game = Game.create(word: word)
    guess = Guess.create(game: game, body: "label")
    guess2 = Guess.create(game: game, body: "chart")

    assert_equal guess.guess_response, "_A_EL"
    assert_equal guess2.guess_response, "C_a__"
  end

  test "#matching_letters returns a hash of matching letters, minus matching indexes" do
    word = Word.find_by(body: "camel")
    game = Game.create(word: word)
    guess = Guess.create(game: game, body: "label")
    guess2 = Guess.create(game: game, body: "chart")

    assert_equal ({}), guess.send(:matching_letters)
    assert_equal ({2=>"a"}), guess2.send(:matching_letters)
  end

  test "#matching_indexes returns a hash of matching indexes" do
    word = Word.find_by(body: "camel")
    game = Game.create(word: word)
    guess = Guess.create(game: game, body: "label")
    guess2 = Guess.create(game: game, body: "chart")

    assert_equal ({1=>"A", 3=>"E", 4=>"L"}), guess.send(:matching_indexes)
    assert_equal ({0=>"C"}), guess2.send(:matching_indexes)
  end

  test "#combined_hash returns merged hashes" do
    word = Word.find_by(body: "camel")
    game = Game.create(word: word)
    guess = Guess.create(game: game, body: "chart")

    assert_equal ({0=>"C", 2=>"a"}), guess.send(:combined_hash)
  end
end
