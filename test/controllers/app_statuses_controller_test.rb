require 'test_helper'

class AppStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app_status = app_statuses(:one)
  end

  test "should get index" do
    get app_statuses_url
    assert_response :success
  end

  test "should get new" do
    get new_app_status_url
    assert_response :success
  end

  test "should create app_status" do
    assert_difference('AppStatus.count') do
      post app_statuses_url, params: { app_status: {  } }
    end

    assert_redirected_to app_status_url(AppStatus.last)
  end

  test "should show app_status" do
    get app_status_url(@app_status)
    assert_response :success
  end

  test "should get edit" do
    get edit_app_status_url(@app_status)
    assert_response :success
  end

  test "should update app_status" do
    patch app_status_url(@app_status), params: { app_status: {  } }
    assert_redirected_to app_status_url(@app_status)
  end

  test "should destroy app_status" do
    assert_difference('AppStatus.count', -1) do
      delete app_status_url(@app_status)
    end

    assert_redirected_to app_statuses_url
  end
end
