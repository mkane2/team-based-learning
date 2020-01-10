class MembershipsController < ApplicationController
  before_action :set_team

  def create
    @member = current_user
    @member.team = @team
    @member.save
    redirect_to dashboard_path
  end

  def add_member
    set_member
    @member.team = @team
    @member.save
    redirect_to team_path(@team.name)
  end

  private

  def set_member
    @member = User.find(params[:user_id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end
end
