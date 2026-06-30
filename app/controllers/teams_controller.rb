class TeamsController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @teams = authenticated? ? Current.user.teams : []
  end

  def show
    @team = Team.find params[:id]
    @user_team = @team.user_teams.find_by(user: Current.user)
  end

  def new
    @team = Team.new
  end

  def create
    @params = params.expect team: [ :title, :description ]
    @team = Current.user.teams.new @params

    if @team.save
      redirect_to team_path(@team), notice: "Team created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @params = params.expect team: [ :title, :description ]
    @team = Team.find(params[:id])

    if @team.update @params
      redirect_to team_path(@team), notice: "Team udpated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Team.destroy params[:id]
    redirect_to teams_path
  end
end
