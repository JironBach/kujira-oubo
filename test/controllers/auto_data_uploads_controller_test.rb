require 'test_helper'

class AutoDataUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @auto_data_upload = auto_data_uploads(:one)
  end

  test "should get index" do
    get auto_data_uploads_url
    assert_response :success
  end

  test "should get new" do
    get new_auto_data_upload_url
    assert_response :success
  end

  test "should create auto_data_upload" do
    assert_difference('AutoDataUpload.count') do
      post auto_data_uploads_url, params: { auto_data_upload: {  } }
    end

    assert_redirected_to auto_data_upload_url(AutoDataUpload.last)
  end

  test "should show auto_data_upload" do
    get auto_data_upload_url(@auto_data_upload)
    assert_response :success
  end

  test "should get edit" do
    get edit_auto_data_upload_url(@auto_data_upload)
    assert_response :success
  end

  test "should update auto_data_upload" do
    patch auto_data_upload_url(@auto_data_upload), params: { auto_data_upload: {  } }
    assert_redirected_to auto_data_upload_url(@auto_data_upload)
  end

  test "should destroy auto_data_upload" do
    assert_difference('AutoDataUpload.count', -1) do
      delete auto_data_upload_url(@auto_data_upload)
    end

    assert_redirected_to auto_data_uploads_url
  end
end
