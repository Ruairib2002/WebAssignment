require "test_helper"

class GpsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gps_index_url
    assert_response :success
  end
end
