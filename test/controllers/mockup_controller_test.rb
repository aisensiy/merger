require 'test_helper'

class MockupControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get buyer" do
    get :buyer
    assert_response :success
  end

  test "should get buy" do
    get :buy
    assert_response :success
  end

  test "should get target" do
    get :target
    assert_response :success
  end

end
