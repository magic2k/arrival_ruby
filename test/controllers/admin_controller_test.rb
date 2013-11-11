require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get remote_db" do
    get :remote_db
    assert_response :success
  end

end
