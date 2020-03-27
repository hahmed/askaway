require 'test_helper'

class AnswersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @question = questions(:one)
  end

  test "fails to create answer for non authenticated user" do
    assert_no_difference('Answer.count') do
      post question_answers_url(@question), params: { question_id: @question.id, answer: { content: "random comment" } }
    end
    assert_redirected_to new_user_session_url
  end

  test "fails to create answer for question owner" do
    sign_in @question.user

    assert_raises do
      post question_answers_url(@question), params: { answer: { content: "random comment" } }
    end
  end

  test "should create answer for user" do
    user = users(:two)
    sign_in user

    assert_difference('Answer.count') do
      post question_answers_url(@question), params: { question_id: @question.id, answer: { content: "random comment" } }
    end

    last = Answer.last
    assert_equal "random comment", last.content
    assert_equal user, last.user
    assert_equal @question, last.question
  end

  test "fails to destroy answer for non authenticated user" do
    answer = answers(:one)

    assert_no_difference('Answer.count') do
      delete question_answer_url(@question, answer)
    end
    assert_redirected_to new_user_session_url
  end

  test "fails to destroy answer for question owner" do
    answer = answers(:one)
    sign_in @question.user

    assert_raises do
      delete question_answer_url(@question, answer)
    end
  end

  test "fails to destroy answer for random user" do
    answer = answers(:one)
    user = users(:three)
    sign_in user

    assert_raises do
      delete question_answer_url(@question, answer)
    end
  end

  test "should destroy answer for user" do
    answer = answers(:one)
    user = users(:two)
    sign_in user

    assert_difference('Answer.count', -1) do
      delete question_answer_url(@question, answer)
    end
  end
end
