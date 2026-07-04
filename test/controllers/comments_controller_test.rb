require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:task_one)
    @team = @task.team
    @comment = comments(:comment_one)

    sign_in_as(users(:user_one))
  end

  test "should create comment on task page" do
    assert_difference("Comment.count") do
      post team_task_comments_url(@team, @task), params: { comment: { content: "New comment" } }
    end

    assert_redirected_to team_task_url(@team, @task)
    assert_equal "New comment", Comment.last.content
  end

  test "should not create comment if team is not found" do
    assert_no_difference("Comment.count") do
      post team_task_comments_url(Team.new(id: 0), @task), params: { comment: { content: "New comment" } }
    end

    assert_response :not_found
  end

  test "should not create comment if task is not found" do
    assert_no_difference("Comment.count") do
      post team_task_comments_url(@team, Task.new(id: 0)), params: { comment: { content: "New comment" } }
    end

    assert_response :not_found
  end

  test "should not create comment with invalid params" do
    assert_no_difference("Comment.count") do
      post team_task_comments_url(@team, @task), params: { comment: { content: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should update comment" do
    patch team_task_comment_url(@team, @task, @comment), params: { comment: { content: "Updated comment" } }

    assert_redirected_to team_task_url(@team, @task)
    @comment.reload
    assert_equal "Updated comment", @comment.content
  end

  test "should not update comment if team is not found" do
    patch team_task_comment_url(Team.new(id: 0), @task, @comment), params: { comment: { content: "Updated comment" } }

    assert_response :not_found
  end

  test "should not update comment if task is not found" do
    patch team_task_comment_url(@team, Task.new(id: 0), @comment), params: { comment: { content: "Updated comment" } }

    assert_response :not_found
  end

  test "should not update comment if comment is not found" do
    patch team_task_comment_url(@team, @task, Comment.new(id: 0)), params: { comment: { content: "Updated comment" } }

    assert_response :not_found
  end

  test "should not update comment with invalid params" do
    patch team_task_comment_url(@team, @task, @comment), params: { comment: { content: "" } }

    assert_response :unprocessable_entity
    @comment.reload
    assert_not_equal "", @comment.content
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete team_task_comment_url(@team, @task, @comment)
    end

    assert_redirected_to team_task_url(@team, @task)
  end

  test "should not destroy comment if team is not found" do
    assert_no_difference("Comment.count") do
      delete team_task_comment_url(Team.new(id: 0), @task, @comment)
    end

    assert_response :not_found
  end

  test "should not destroy comment if task is not found" do
    assert_no_difference("Comment.count") do
      delete team_task_comment_url(@team, Task.new(id: 0), @comment)
    end

    assert_response :not_found
  end

  test "should not destroy comment if comment is not found" do
    assert_no_difference("Comment.count") do
      delete team_task_comment_url(@team, @task, Comment.new(id: 0))
    end

    assert_response :not_found
  end
end
