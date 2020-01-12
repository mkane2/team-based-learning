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

  def import
    User.batch_import(params[:file])
    redirect_to admin_dashboard_path, notice: "Users successfully imported"
  end
end
