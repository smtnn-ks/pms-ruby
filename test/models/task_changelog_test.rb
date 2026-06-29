require_relative "../test_helper"

class TaskChangelogTest < ActiveSupport::TestCase
  test "must have user" do
    task_changelog = task_changelogs(:task_changelog_one)
    user = users(:user_one)

    assert_equal user, task_changelog.user
  end

  test "must have task" do
    task_changelog = task_changelogs(:task_changelog_one)
    task = tasks(:task_one)

    assert_equal task, task_changelog.task
  end
end
