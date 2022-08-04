class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy, :leaderboard]

  # GET /quizzes
  # GET /quizzes.json
  def index
    if user_signed_in? && current_user.admin?
      @quizzes = Quiz.all.order(due_date: :asc)
    elsif user_signed_in?
      @quizzes = current_user.enrolled_courses.first.quizzes.order(due_date: :asc)
    else
      redirect_to root_url, notice: "Sorry, you need to sign in first."
    end
  end

  def import
    @errors = Quiz.batch_import(params[:file], current_user.id)
    if @errors.empty?
      redirect_to admin_dashboard_path, notice: "Quizzes successfully imported."
    else
      redirect_to admin_dashboard_path, notice: "#{@errors.join(", ")}"
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    if user_signed_in? && current_user.admin?
      @question = @quiz.questions.build
    elsif user_signed_in?
    else
      redirect_to root_url, notice: "Sorry, you have to sign in first."
    end
  end

  # GET /quizzes/new
  def new
    if user_signed_in? && current_user.admin?
      @quiz = Quiz.new
      @courses = Course.all
    else
      redirect_to root_url, notice: "Sorry, you have to sign in first."
    end
  end

  # GET /quizzes/1/edit
  def edit
    if user_signed_in? && current_user.admin?
      @courses = Course.all
      @choice = Choice.new
    else
      redirect_to root_url, notice: "Sorry, you have to sign in first."
    end
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    if user_signed_in? && current_user.admin?
      @courses = Course.all
      @quiz = current_user.quizzes.build(quiz_params)

      respond_to do |format|
        if @quiz.save
          format.html { redirect_to @quiz, notice: 'Quiz was successfully created.' }
          format.json { render :show, status: :created, location: @quiz }
        else
          format.html { render :new }
          format.json { render json: @quiz.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url, notice: "Sorry, you have to sign in first."
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    if current_user.admin?
      respond_to do |format|
        if @quiz.update(quiz_params)
          format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
          format.json { render :show, status: :ok, location: @quiz }
        else
          format.html { render :edit }
          format.json { render json: @quiz.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url, notice: "Sorry, you need to sign in first."
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    if user_signed_in? && current_user.admin?
      @quiz.destroy
      respond_to do |format|
        format.html { redirect_to quizzes_url, notice: 'Quiz was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_url, notice: "Sorry, you need to sign in first."
    end
  end

  def leaderboard
    if user_signed_in?
      @teams = Course.where(id: @quiz.course_id).first.teams
      @attempts = Attempt.where(quiz_id: @quiz.id).where(team_attempt: true).order("points DESC")
    else
      redirect_to root_url, notice: "Sorry, you need to sign in first."
    end
  end

  def results
    if user_signed_in? && current_user.admin?
      @quiz = Quiz.find(params[:id])
      @questions = @quiz.questions
      @choices = @quiz.choices
    else
      redirect_to root_url, notice: "Sorry, you need to sign in first."
    end
  end

  def scores
    if user_signed_in? && current_user.admin?
      @quiz = Quiz.find(params[:id])
      @course = @quiz.course
      if params[:sort] == "lastdesc"
        @students = @course.users.order(lastname: :desc)
      elsif params[:sort] == "team"
        @students = @course.users.joins(:team).order("teams.name")
      elsif params[:sort] == "individualasc"
        @students = @course.users.joins(:attempts).where("attempts.team_attempt = ?", false).merge(Attempt.order(points: :asc)).uniq
      elsif params[:sort] == "individualdesc"
        @students = @course.users.joins(:attempts).where("attempts.team_attempt = ?", false).merge(Attempt.order(points: :desc)).uniq
      elsif params[:sort] == "teamasc"
        @students = @course.users.order(lastname: :asc)
      elsif params[:sort] == "teamdesc"
        @students = @course.users.order(lastname: :asc)
      else
        @students = @course.users.order(lastname: :asc)
      end
    else
      redirect_to root_url, notice: "Sorry, you need to sign in first."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name, :description, :course_id, :due_date, :randomize_questions, :randomize_answers, :show_all_questions, question_attributes: [:id, :body, :_destroy, choice_attributes: [:id, :choice_body, :correct, :_destroy]])
    end
end
