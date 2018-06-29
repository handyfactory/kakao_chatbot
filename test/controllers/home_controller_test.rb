require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get keyboard" do
    get :keyboard
    assert_response :success
  end

end
