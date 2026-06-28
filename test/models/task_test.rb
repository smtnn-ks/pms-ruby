require_relative "../test_helper"

class TaskTest < ActiveSupport::TestCase
  test "empty task must be invalid" do
    assert !(Task.new.valid?)
  end

  test "must be valid" do
    task = Task.new title: "a" * 128, description: "a" * 1024, team: teams(:team_one), author: users(:user_one)
    assert task.valid?
  end

  test "title must be shorter than 128 characters" do
    task = Task.new title: "a" * 128, description: "a" * 1024, team: teams(:team_one), author: users(:user_one)
    task.title << "a"

    assert !(task.valid?)
  end

  test "desciption must be shorter than 1024 characters" do
    task = Task.new title: "a" * 128, description: "a" * 1024, team: teams(:team_one), author: users(:user_one)
    task.description << "a"

    assert !(task.valid?)
  end

  test "must have team" do
    task = tasks(:task_one)
    team = teams(:team_one)

    assert_equal team, task.team
  end

  test "must have author" do
    task = tasks(:task_one)
    user = users(:user_one)

    assert_equal user, task.author
  end

  test "may have or have not assignee" do
    task_one = tasks(:task_one)
    task_two = tasks(:task_two)

    assert task_one.assignee.present?
    assert !(task_two.assignee.present?)
  end

  test "has comments" do
    task = tasks(:task_one)
    comments = [ comments(:comment_one), comments(:comment_two) ]

    assert_equal comments.sort, task.comments.sort
  end

  test "has changelogs" do
    task = tasks(:task_one)
    task_changelogs = [ task_changelogs(:task_changelog_one), task_changelogs(:task_changelog_two) ]

    assert_equal task_changelogs.sort, task.task_changelogs.sort
  end
end
