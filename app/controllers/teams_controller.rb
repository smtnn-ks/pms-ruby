class TeamsController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]

  def index
    @teams = authenticated? ? Current.user.teams : []
  end

  def new
    @team = Team.new
  end

  def create
    @params = params.expect team: [ :title, :description ]

    if Current.user.teams.create @params
      redirect_to teams_path, notice: "Team created"
    else
      render :new, status: :unprocessable_entity
    end
  end
end
