require 'test_helper'

class SGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @s_group = s_groups(:one)
  end

  test "should get index" do
    get s_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_s_group_url
    assert_response :success
  end

  test "should create s_group" do
    assert_difference('SGroup.count') do
      post s_groups_url, params: { s_group: {  } }
    end

    assert_redirected_to s_group_url(SGroup.last)
  end

  test "should show s_group" do
    get s_group_url(@s_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_s_group_url(@s_group)
    assert_response :success
  end

  test "should update s_group" do
    patch s_group_url(@s_group), params: { s_group: {  } }
    assert_redirected_to s_group_url(@s_group)
  end

  test "should destroy s_group" do
    assert_difference('SGroup.count', -1) do
      delete s_group_url(@s_group)
    end

    assert_redirected_to s_groups_url
  end
end
