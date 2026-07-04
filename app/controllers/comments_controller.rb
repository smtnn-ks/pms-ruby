class CommentsController < ApplicationController
  before_action :get_team
  before_action :get_task
  before_action :get_comment, only: %i[ edit update destroy ]

  def edit
  end

  def create
    @comment = @task.comments.new(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to team_task_path(@team, @task)
    else
      prepare_task_page
      render "tasks/show", status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to team_task_path(@team, @task)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    redirect_to team_task_path(@team, @task)
  end

  private

  def get_team
    @team = Current.user.teams.find params[:team_id]
  end

  def get_task
    @task = @team.tasks.find params[:task_id]
  end

  def get_comment
    @comment = @task.comments.find params[:id]
  end

  def comment_params
    params.expect(comment: [ :content ])
  end

  def prepare_task_page
    @comments = @task.comments.includes(:user).order(created_at: :asc)
  end
end
