require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    Searchkick.enable_callbacks
    question = questions(:one)
    Question.reindex
    Question.search_index.refresh
    get questions_url
    assert_response :success
    Searchkick.disable_callbacks
  end

  test "should get new" do
    get new_question_url
    assert_response :success
  end

  test "fails to create question for non authenticated user" do
    assert_no_difference('Question.count') do
      post questions_url, params: { question: { content: "content time", title: "my title" } }
    end
    assert_redirected_to new_user_session_url
  end

  test "should create question" do
    user = users(:one)
    question = questions(:one)

    sign_in user

    assert_difference('Question.count') do
      post questions_url, params: { question: { content: "content time", title: "my title" } }
    end

    last = Question.last
    assert_redirected_to question_url(last)
    assert_equal "content time", last.content
    assert_equal "my title", last.title
    assert_equal user, last.user
  end

  test "should show question" do
    question = questions(:one)
    get question_url(question)
    assert_response :success
  end

  test "fails to get edit for non authenticated user" do
    question = questions(:one)
    get edit_question_url(question)
    assert_redirected_to new_user_session_url
  end

  test "should get edit" do
    user = users(:one)
    question = questions(:one)
    sign_in user

    get edit_question_url(question)
    assert_response :success
  end

  test "should update question" do
    user = users(:one)
    question = questions(:one)

    sign_in user

    patch question_url(question), params: { question: { content: "Yet another content", title: "Hi" } }

    question.reload
    assert_redirected_to question_url(question)
    assert_equal "Yet another content", question.content
    assert_equal "Hi", question.title
  end

  test "fails to destroy question for non authenticated user" do
    question = questions(:one)

    assert_no_difference('Question.count', -1) do
      delete question_url(question)
    end

    assert_redirected_to new_user_session_url
  end

  test "should destroy question" do
    user = users(:one)
    question = questions(:one)

    sign_in user

    assert_difference('Question.count', -1) do
      delete question_url(question)
    end

    assert_redirected_to questions_url
  end
end
