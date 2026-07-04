require "test_helper"

class TaskChangelogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:task_one)
    @team = @task.team
    sign_in_as(users(:user_one))
  end

  test "should get index" do
    get team_task_task_changelogs_url(@team, @task)

    assert_response :success
    assert_select "h1", "Task changelog"
  end

  test "should not get index if team is not found" do
    get team_task_task_changelogs_url(99999, @task)

    assert_response :not_found
  end

  test "should not get index if task is not found" do
    get team_task_task_changelogs_url(@team, 99999)

    assert_response :not_found
  end
end
