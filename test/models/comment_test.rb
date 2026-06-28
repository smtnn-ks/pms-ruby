require_relative "../test_helper"

class CommentTest < ActiveSupport::TestCase
  test "empty content must be invalid" do
    assert !(Comment.new.valid?)
  end

  test "must be valid" do
    comment = Comment.new content: "a" * 1024, user: users(:user_one), task: tasks(:task_one)
    assert comment.valid?
  end

  test "content must be shorter than 1024" do
    comment = Comment.new content: "a" * 1024, user: users(:user_one), task: tasks(:task_one)
    comment.content << "a"

    assert !(comment.valid?)
  end

  test "must have user" do
    comment = comments(:comment_one)
    user = users(:user_one)

    assert_equal user, comment.user
  end

  test "must have task" do
    comment = comments(:comment_one)
    task = tasks(:task_one)

    assert_equal task, comment.task
  end
end
