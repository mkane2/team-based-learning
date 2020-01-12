class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy, :leaderboard]

  # GET /quizzes
  # GET /quizzes.json
  def index
    if current_user.admin?
      @quizzes = Quiz.all
    else
      @quizzes = current_user.enrolled_courses.first.quizzes
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
    @question = @quiz.questions.build
    #@choice = @question.choices.build
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
    @courses = Course.all
  end

  # GET /quizzes/1/edit
  def edit
    @courses = Course.all
    @choice = Choice.new
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
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
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to @quiz, notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def leaderboard
    @teams = Course.where(id: @quiz.course_id).first.teams
    @attempts = Attempt.where(quiz_id: @quiz.id).where.not(team_id: nil).order("points DESC")
    # @teams = @teams.joins(:attempts).where(quiz_id: @quiz.id).order("points DESC")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:name, :description, :course_id, question_attributes: [:id, :body, :_destroy, choice_attributes: [:id, :choice_body, :correct, :_destroy]])
    end
end
