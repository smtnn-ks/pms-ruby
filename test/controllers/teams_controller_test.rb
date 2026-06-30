require "test_helper"

class TeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @team = teams(:team_one)

    assert_queries_count 4 do
      sign_in_as(users(:user_one))
    end
  end

  test "should get index" do
    get teams_url
    assert_response :success
  end

  test "should get new" do
    get new_team_url
    assert_response :success
  end

  test "should create team" do
    assert_difference("Team.count") do
      post teams_url, params: { team: { title: "title", description: "description" } }
    end

    assert_redirected_to team_url(Team.last)
  end

  test "should not create if validation fails" do
    post teams_url, params: { team: {} }
    assert_response :bad_request
  end

  test "should show team" do
    get team_url(@team)
    assert_response :success
  end

  test "should not show if team is not found" do
    get team_url(Team.new id: 0)
    assert_response :not_found
  end

  test "should get edit" do
    get edit_team_url(@team)
    assert_response :success
  end

  test "should not get edit if team is not found" do
    get edit_team_url(Team.new id: 0)
    assert_response :not_found
  end

  test "should update team" do
    patch team_url(@team), params: { team: { title: "title", description: "description" } }
    assert_redirected_to team_url(@team)
  end

  test "should not update if validation fails" do
    patch team_url(@team), params: { team: {} }

    assert_response :bad_request
    assert_equal @team.updated_at, @team.reload.updated_at
  end

  test "should not update if team is not found" do
    patch team_url(Team.new id: 0), params: { team: { title: "title", description: "description" } }
    assert_response :not_found
    assert_raises ActiveRecord::RecordNotFound do
      Team.find 0
    end
  end

  test "should destroy team" do
    assert_difference("Team.count", -1) do
      delete team_url(@team)
    end

    assert_redirected_to teams_url
  end

  test "should not destroy if team is not found" do
    assert_difference("Team.count", 0) do
      delete team_url(Team.new id: 0)
    end

    assert_response :not_found
  end
end
