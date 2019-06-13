require 'test_helper'

class ApplicantDisplaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @applicant_display = applicant_displays(:one)
  end

  test "should get index" do
    get applicant_displays_url
    assert_response :success
  end

  test "should get new" do
    get new_applicant_display_url
    assert_response :success
  end

  test "should create applicant_display" do
    assert_difference('ApplicantDisplay.count') do
      post applicant_displays_url, params: { applicant_display: {  } }
    end

    assert_redirected_to applicant_display_url(ApplicantDisplay.last)
  end

  test "should show applicant_display" do
    get applicant_display_url(@applicant_display)
    assert_response :success
  end

  test "should get edit" do
    get edit_applicant_display_url(@applicant_display)
    assert_response :success
  end

  test "should update applicant_display" do
    patch applicant_display_url(@applicant_display), params: { applicant_display: {  } }
    assert_redirected_to applicant_display_url(@applicant_display)
  end

  test "should destroy applicant_display" do
    assert_difference('ApplicantDisplay.count', -1) do
      delete applicant_display_url(@applicant_display)
    end

    assert_redirected_to applicant_displays_url
  end
end
