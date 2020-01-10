require 'test_helper'

class AttemtpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attemtp = attemtps(:one)
  end

  test "should get index" do
    get attemtps_url
    assert_response :success
  end

  test "should get new" do
    get new_attemtp_url
    assert_response :success
  end

  test "should create attemtp" do
    assert_difference('Attemtp.count') do
      post attemtps_url, params: { attemtp: { quiz_id: @attemtp.quiz_id, team_id: @attemtp.team_id, user_id: @attemtp.user_id } }
    end

    assert_redirected_to attemtp_url(Attemtp.last)
  end

  test "should show attemtp" do
    get attemtp_url(@attemtp)
    assert_response :success
  end

  test "should get edit" do
    get edit_attemtp_url(@attemtp)
    assert_response :success
  end

  test "should update attemtp" do
    patch attemtp_url(@attemtp), params: { attemtp: { quiz_id: @attemtp.quiz_id, team_id: @attemtp.team_id, user_id: @attemtp.user_id } }
    assert_redirected_to attemtp_url(@attemtp)
  end

  test "should destroy attemtp" do
    assert_difference('Attemtp.count', -1) do
      delete attemtp_url(@attemtp)
    end

    assert_redirected_to attemtps_url
  end
end
