class TaskChangelogsController < ApplicationController
  before_action :get_team
  before_action :get_task

  def index
    @task_changelogs = @task.task_changelogs.includes(:user).order(created_at: :desc)
  end

  private

  def get_team
    @team = Current.user.teams.find params[:team_id]
  end

  def get_task
    @task = @team.tasks.find params[:task_id]
  end
end
