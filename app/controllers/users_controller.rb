class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:name])
    if @user.team.present?
      @team = @user.team
    end
    @quizzes = @user.enrolled_courses.first.quizzes.where(active: true).order(due_date: :asc)
  end

  def edit
    if user_signed_in? && current_user.admin?
      @user = User.find_by(username: params[:name])
      if @user.team.present?
        @team = @user.team
      end
      @teams = Team.all
    else
      redirect_to root_url
    end
  end

  def update
    @user = User.find_by(username: params[:name])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user.username), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if user_signed_in? && current_user.admin?
      @user = User.find_by(username: params[:name])
      @user.destroy
      redirect_to admin_dashboard_path
    else
      redirect_to root_url
    end
  end

  def index
    if user_signed_in? && current_user.admin?
      @quizzes = Quiz.all
      @quizzes = @quizzes.order(due_date: :asc)
    elsif user_signed_in?
      @course = current_user.enrolled_courses.first
      @quizzes = @course.quizzes.where(active: true)
      @quizzes = @quizzes.order(due_date: :asc)
    else
      if User.where(admin: true).present?
      else
        User.create! username: @professor, password: @defaultpassword, email: @professor_email, admin: true
      end
    end
  end

  def dashboard
    @user = current_user
    if @user.team.present?
      @team = @user.team
    end
    @course = current_user.enrolled_courses.first
    @quizzes = @course.quizzes.where(active: true).order(due_date: :asc)
    @enrollment = current_user.enrollments.build
  end

  def import
    @errors = User.batch_import(params[:file])
    if @errors.empty?
      redirect_to admin_dashboard_path, notice: "Users successfully imported."
    else
      redirect_to admin_dashboard_path, notice: "#{@errors.join(", ")}"
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :firstname, :lastname, :studentid, :team_id)
  end

end
