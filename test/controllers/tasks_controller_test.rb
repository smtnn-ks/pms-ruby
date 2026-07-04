require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:task_one)
    @team = @task.team

    assert_queries_count 4 do
      sign_in_as(users(:user_one))
    end
  end

  test "should show task" do
    get team_task_url(@team, @task)
    assert_response :success
  end

  test "should not show task if team is not found" do
    get team_task_url(Team.new(id: 0), @task)
    assert_response :not_found
  end

  test "should not show task if task is not found" do
    get team_task_url(@team, Task.new(id: 0))
    assert_response :not_found
  end

  test "should get new" do
    get new_team_task_url(@team)
    assert_response :success
  end

  test "should not get new if team is not found" do
    get new_team_task_url(Team.new(id: 0))
    assert_response :not_found
  end

  test "should create task" do
    assert_difference("Task.count") do
      post team_tasks_url(@team), params: { task: { title: "New Task", description: "Created from controller test" } }
    end

    @last_task = Task.last
    assert_equal @last_task.author, users(:user_one)

    assert_redirected_to team_task_url(@team, @last_task)
  end

  test "should create task with assignee" do
    assert_difference("Task.count") do
      post team_tasks_url(@team), params: { task: { title: "Assigned Task", description: "Task with assignee", assignee_id: users(:user_two).id } }
    end

    task = Task.last
    assert_equal users(:user_two), task.assignee
    assert_redirected_to team_task_url(@team, task)
  end

  test "should not create task if team is not found" do
    assert_no_difference("Task.count") do
      post team_tasks_url(Team.new(id: 0)), params: { task: { title: "New Task", description: "Created from controller test" } }
    end

    assert_response :not_found
  end

    test "should not create task with invalid params" do
    assert_no_difference("Task.count") do
      post team_tasks_url(@team), params: { task: { title: "", description: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_team_task_url(@team, @task)
    assert_response :success
  end

  test "should not get edit if team is not found" do
    get edit_team_task_url(Team.new(id: 0), @task)
    assert_response :not_found
  end

  test "should not get edit if task is not found" do
    get edit_team_task_url(@team, Task.new(id: 0))
    assert_response :not_found
  end

  test "should update task" do
    patch team_task_url(@team, @task), params: { task: { title: "Updated Task Title" } }
    assert_redirected_to team_task_url(@team, @task)
    @task.reload
    assert_equal "Updated Task Title", @task.title
  end

  test "should update task assignee" do
    patch team_task_url(@team, @task), params: { task: { assignee_id: users(:user_two).id } }

    assert_redirected_to team_task_url(@team, @task)
    @task.reload
    assert_equal users(:user_two), @task.assignee
  end

  test "should not update task if team is not found" do
    patch team_task_url(Team.new(id: 0), @task), params: { task: { title: "Updated Task Title" } }

    assert_response :not_found
    @task.reload
    assert_not_equal "Updated Task Title", @task.title
  end

  test "should not update task if task is not found" do
    patch team_task_url(@team, Task.new(id: 0)), params: { task: { title: "Updated Task Title" } }

    assert_response :not_found
    @task.reload
    assert_not_equal "Updated Task Title", @task.title
  end

  test "should not update task with invalid params" do
    patch team_task_url(@team, @task), params: { task: { title: "" } }

    assert_response :unprocessable_entity
    @task.reload
    assert_not_equal "", @task.title
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete team_task_url(@team, @task)
    end

    assert_redirected_to team_url(@team)
  end

  test "should not destroy task if team is not found" do
    assert_no_difference("Task.count") do
      delete team_task_url(Team.new(id: 0), @task)
    end

    assert_response :not_found
  end

  test "should not destroy task if task is not found" do
    assert_no_difference("Task.count") do
      delete team_task_url(@team, Task.new(id: 0))
    end

    assert_response :not_found
  end
end
