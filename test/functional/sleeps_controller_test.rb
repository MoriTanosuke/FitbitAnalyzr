require 'test_helper'

class SleepsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @sleep = sleeps(:one)
    @saved_sleep = sleeps(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sleeps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sleep" do
    assert_difference('Sleep.count') do
      post :create, :sleep => {:sleep => @sleep.date.strftime('%Y-%m-%d')}
    end

    assert_redirected_to sleep_path(assigns(:sleep))
  end

  test "should show sleep" do
    get :show, :id => @sleep.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sleep.to_param
    assert_response :success
  end

  test "should update sleep" do
    put :update, :id => @sleep.to_param, :sleep => @sleep.attributes
    assert_redirected_to sleep_path(assigns(:sleep))
  end

  test "should destroy sleep" do
    assert_difference('Sleep.count', -1) do
      delete :destroy, :id => @sleep.to_param
    end

    assert_redirected_to sleeps_path
  end
end
