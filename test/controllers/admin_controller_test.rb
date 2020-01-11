require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get admin_dashboard_url
    assert_response :success
  end

  test "should get csv_template" do
    get admin_csv_template_url
    assert_response :success
  end

  test "should get generate_csv" do
    get admin_generate_csv_url
    assert_response :success
  end

  test "should get download_csv" do
    get admin_download_csv_url
    assert_response :success
  end

end
