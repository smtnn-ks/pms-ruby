class TasksController < ApplicationController
  def show
    @task = Task.find params[:id]
  end

  def new
    @task = Task.new
  end

  def create
    @params = params.expect task: [ :title, :description ]
    @task = Task.new @params
    @task.team = Team.find params[:team_id]
    @task.author = Current.user

    if @task.save
      pp @task
      redirect_to team_task_path(params[:team_id], @task)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
