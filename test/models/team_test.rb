require_relative "../test_helper"

class TeamTest < ActiveSupport::TestCase
  test "empty team is invalid" do
    assert !(Team.new.valid?)
  end

  test "must be valid" do
    team = Team.new title: "a" * 128, description: "a" * 1024
    assert team.valid?
  end

  test "title must be shorter than 128 characters" do
    team = Team.new title: "a" * 128, description: "a" * 1024
    team.title << "a"

    assert !(team.valid?)
  end

  test "description must be shorter than 1024 characters" do
    team = Team.new title: "a" * 128, description: "a" * 1024
    team.description << "a"

    assert !(team.valid?)
  end

  test "team has users" do
    team = teams(:team_one)
    users = [ users(:user_one), users(:user_two) ]

    assert_equal users.sort, team.users.sort
  end

  test "team has user_teams and roles" do
    team = teams(:team_one)
    user = users(:user_one)
    user_teams = [ user_teams(:user_one_to_team_one), user_teams(:user_two_to_team_one) ]

    assert_equal user_teams.sort, team.user_teams.sort
    assert team.user_teams.find_by(user: user).owner?
  end

  test "team has tasks" do
    team = teams(:team_one)
    tasks = [ tasks(:task_one) ]

    assert_equal tasks.sort, team.tasks.sort
  end
end
