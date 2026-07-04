class TasksController < ApplicationController
  before_action :get_team
  before_action :get_task, only: %i[ show edit update destroy ]

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @params = params.expect task: [ :title, :description, :assignee_id ]
    @task = @team.tasks.new @params
    @task.author = Current.user

    if @task.save
      redirect_to team_task_path(@team, @task)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @params = params.expect task: [ :title, :description, :assignee_id ]
    if @task.update @params
      redirect_to team_task_path(@team, @task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to team_path(@team)
  end

  private

  def get_team
    @team = Current.user.teams.find params[:team_id]
  end

  def get_task
    @task = @team.tasks.find params[:id]
  end
end
