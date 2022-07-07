require "test_helper"

class WordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get '/words'
    assert_response :success
  end
end
