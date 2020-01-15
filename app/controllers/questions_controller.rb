class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    if user_signed_in? && current_user.admin? && params[:quiz_id].present?
      @questions = Question.where(quiz_id: params[:quiz_id])
    elsif current_user.admin?
      @questions = Question.all
    else
      redirect_to root_url, notice: "Sorry, you have to sign in first."
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @quizzes = Quiz.all
  end

  # GET /questions/1/edit
  def edit
    @quizzes = Quiz.all
    @quiz = @question.quiz
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question.quiz, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        @quiz = Quiz.find(params[:quiz_id])
        format.html { redirect_to @question.quiz, notice: @question.errors }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    @errors = Question.batch_import(params[:file])
    if @errors.empty?
      redirect_to admin_dashboard_path, notice: "Questions successfully imported."
    else
      redirect_to admin_dashboard_path, notice: "#{@errors.join(", ")}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:body, :quiz_id, choices_attributes: [:id, :choice_body, :correct, :question_id, :_destroy])
    end

end
