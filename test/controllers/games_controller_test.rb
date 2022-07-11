require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get show for a game" do
    get '/games'
    assert_response :success
  end
end
