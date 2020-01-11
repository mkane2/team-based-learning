class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:name])
    if @user.team.present?
      @team = @user.team
    end
  end

  def index
  end

  def dashboard
    @user = current_user
    @courses = Course.all
    @enrollment = current_user.enrollments.build
  end
end
