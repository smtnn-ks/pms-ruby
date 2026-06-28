require "test_helper"

class UserTeamTest < ActiveSupport::TestCase
  test "user_team has user and team" do
    user_team = user_teams(:user_one_to_team_one)
    user = users(:user_one)
    team = teams(:team_one)

    assert_equal user_team.user, user
    assert_equal user_team.team, team
  end
end
