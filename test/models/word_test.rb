require "test_helper"

class WordTest < ActiveSupport::TestCase

  test "word will not create if body is nil" do
    word = Word.create(body: nil)
    assert_equal false, word.valid?
  end

  test "word will not create if body length is not equal to 5" do
    word = Word.create(body: "longer")
    word_two = Word.create(body: "less")

    assert_equal false, word.valid?
    assert_equal false, word_two.valid?
    assert_equal word.errors.messages, {:body=>["is the wrong length (should be 5 characters)"]}
    assert_equal word_two.errors.messages, {:body=>["is the wrong length (should be 5 characters)"]}
  end

  test "word will create if body exists and has length equal to 5" do
    word = Word.create(body: "mambo")

    assert word.valid?
    assert_equal word.errors.messages, {}
  end
end
