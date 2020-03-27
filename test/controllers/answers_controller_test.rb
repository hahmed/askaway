require 'test_helper'

class AnswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:one)
  end

  test "fails to create answer for non authenticated user" do
    assert_no_difference('Question.count') do
      post question_answers_url(@question), params: { answer: { content: "random comment" } }
    end
    assert_redirected_to new_user_session_url
  end
end
