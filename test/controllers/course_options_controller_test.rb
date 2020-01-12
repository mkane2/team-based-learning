require 'test_helper'

class CourseOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_option = course_options(:one)
  end

  test "should get index" do
    get course_options_url
    assert_response :success
  end

  test "should get new" do
    get new_course_option_url
    assert_response :success
  end

  test "should create course_option" do
    assert_difference('CourseOption.count') do
      post course_options_url, params: { course_option: { active: @course_option.active, course_id: @course_option.course_id, duration: @course_option.duration, randomize_answers: @course_option.randomize_answers, randomize_questions: @course_option.randomize_questions, show_all_questions: @course_option.show_all_questions, user_id: @course_option.user_id } }
    end

    assert_redirected_to course_option_url(CourseOption.last)
  end

  test "should show course_option" do
    get course_option_url(@course_option)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_option_url(@course_option)
    assert_response :success
  end

  test "should update course_option" do
    patch course_option_url(@course_option), params: { course_option: { active: @course_option.active, course_id: @course_option.course_id, duration: @course_option.duration, randomize_answers: @course_option.randomize_answers, randomize_questions: @course_option.randomize_questions, show_all_questions: @course_option.show_all_questions, user_id: @course_option.user_id } }
    assert_redirected_to course_option_url(@course_option)
  end

  test "should destroy course_option" do
    assert_difference('CourseOption.count', -1) do
      delete course_option_url(@course_option)
    end

    assert_redirected_to course_options_url
  end
end
