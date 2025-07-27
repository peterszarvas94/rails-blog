require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
  end

  test "should get index" do
    get dashboard_index_url
    assert_response :success
  end

  test "should redirect to login when not authenticated" do
    delete session_url # Sign out
    get dashboard_index_url
    assert_redirected_to new_session_url
  end
end
