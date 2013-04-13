require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "rendering the registration page" do
    get :new
    assert_response :success
    assert_template "new"
  end

  test "registering a new user" do
    testuser = users(:testuser)
    post :create, :name=> testuser.name, :login=> testuser.name, :email=>testuser.email, :password=>'secret'
    assert_response :success
    assert_template "new"
  end
end
