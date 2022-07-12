require "test_helper"

class GameTest < ActiveSupport::TestCase
  test "game will not create if word is nil" do
    game = Game.create(word: nil)

    assert_equal false, game.valid?
    assert_equal game.errors.messages, {:word=>["must exist", "can't be blank"]}
  end

  test "game will create if valid" do
    word = Word.create(body: "mambo")
    game = Game.create(word: word)

    assert_equal true, game.valid?
  end
end
