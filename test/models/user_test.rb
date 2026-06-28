require_relative "../test_helper"

class UserTest < ActiveSupport::TestCase
  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "user has teams" do
    user = users(:user_one)
    teams = [ teams(:team_one), teams(:team_two) ]

    assert_equal teams.sort, user.teams.sort
  end

  test "user has user_team record with a role" do
    user = users(:user_one)
    team = teams(:team_one)
    user_teams = [ user_teams(:user_one_to_team_one), user_teams(:user_one_to_team_two) ]

    assert_equal user_teams.sort, user.user_teams.sort
    assert user.user_teams.find_by(team: team).owner?
  end
end
