require 'test_helper'

class QuizControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get submit" do
    get :submit
    assert_response :success
  end

  test "should get next_question" do
    get :next_question
    assert_response :success
  end

end
