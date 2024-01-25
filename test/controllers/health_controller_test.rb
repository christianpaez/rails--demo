require "test_helper"

class HealthControllerTest < ActionDispatch::IntegrationTest
  test "Must return 200 OK" do
    get "/health"
    assert_response :ok
  end
end
