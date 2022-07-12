require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get show for a game" do
    word = Word.create(body: "hello")
    game = Game.create(word: word)

    get "/games/#{game.id}"
    assert_response :success
  end
end
