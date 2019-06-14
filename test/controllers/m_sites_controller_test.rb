require 'test_helper'

class MSitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @m_site = m_sites(:one)
  end

  test "should get index" do
    get m_sites_url
    assert_response :success
  end

  test "should get new" do
    get new_m_site_url
    assert_response :success
  end

  test "should create m_site" do
    assert_difference('MSite.count') do
      post m_sites_url, params: { m_site: {  } }
    end

    assert_redirected_to m_site_url(MSite.last)
  end

  test "should show m_site" do
    get m_site_url(@m_site)
    assert_response :success
  end

  test "should get edit" do
    get edit_m_site_url(@m_site)
    assert_response :success
  end

  test "should update m_site" do
    patch m_site_url(@m_site), params: { m_site: {  } }
    assert_redirected_to m_site_url(@m_site)
  end

  test "should destroy m_site" do
    assert_difference('MSite.count', -1) do
      delete m_site_url(@m_site)
    end

    assert_redirected_to m_sites_url
  end
end
