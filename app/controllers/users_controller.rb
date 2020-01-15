class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:name])
    if @user.team.present?
      @team = @user.team
    end
  end

  def index
    if user_signed_in? && current_user.admin?
      @quizzes = Quiz.all
    elsif user_signed_in?
      @course = current_user.enrolled_courses.first
      @quizzes = @course.quizzes.where(active: true).order(due_date: :asc)
    else
      if User.where(admin: true).present?
      else
        puts "email should be here #{@professor_email}"
        User.create! username: @professor, password: @default, email: @professor_email, admin: true
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

end
