require "test_helper"

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sales_show_url
    assert_response :success
  end
end
