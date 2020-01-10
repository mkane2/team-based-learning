require 'test_helper'

class AttemptChoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attempt_choice = attempt_choices(:one)
  end

  test "should get index" do
    get attempt_choices_url
    assert_response :success
  end

  test "should get new" do
    get new_attempt_choice_url
    assert_response :success
  end

  test "should create attempt_choice" do
    assert_difference('AttemptChoice.count') do
      post attempt_choices_url, params: { attempt_choice: { attempts_id: @attempt_choice.attempts_id, choices_id: @attempt_choice.choices_id, questions_id: @attempt_choice.questions_id, team_id: @attempt_choice.team_id, user_id: @attempt_choice.user_id } }
    end

    assert_redirected_to attempt_choice_url(AttemptChoice.last)
  end

  test "should show attempt_choice" do
    get attempt_choice_url(@attempt_choice)
    assert_response :success
  end

  test "should get edit" do
    get edit_attempt_choice_url(@attempt_choice)
    assert_response :success
  end

  test "should update attempt_choice" do
    patch attempt_choice_url(@attempt_choice), params: { attempt_choice: { attempts_id: @attempt_choice.attempts_id, choices_id: @attempt_choice.choices_id, questions_id: @attempt_choice.questions_id, team_id: @attempt_choice.team_id, user_id: @attempt_choice.user_id } }
    assert_redirected_to attempt_choice_url(@attempt_choice)
  end

  test "should destroy attempt_choice" do
    assert_difference('AttemptChoice.count', -1) do
      delete attempt_choice_url(@attempt_choice)
    end

    assert_redirected_to attempt_choices_url
  end
end
