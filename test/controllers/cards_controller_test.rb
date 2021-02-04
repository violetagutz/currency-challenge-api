require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get cards_create_url
    assert_response :success
  end
end
