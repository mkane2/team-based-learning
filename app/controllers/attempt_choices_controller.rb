class AttemptChoicesController < ApplicationController
  before_action :set_attempt_choice, only: [:show, :edit, :update, :destroy]

  # GET /attempt_choices
  # GET /attempt_choices.json
  def index
    @attempt_choices = AttemptChoice.all
  end

  # GET /attempt_choices/1
  # GET /attempt_choices/1.json
  def show
  end

  # GET /attempt_choices/new
  def new
    @attempt_choice = AttemptChoice.new
  end

  # GET /attempt_choices/1/edit
  def edit
  end

  # POST /attempt_choices
  # POST /attempt_choices.json

  def points_possible(question)
    @total = question.choices.size + 1
    @attempts = current_user.attempt_choices.where(question_id: question.id).size
    @possible = @total - @attempts
  end

  def team_points(question)
    @total = question.choices.size
    @attempts = current_user.team.attempt_choices.where(question_id: question.id).size - 1
    @possible = @total - @attempts
  end

  def create
    @user = User.find(params[:user_id])
    @team = @user.team
    @attempt = Attempt.find(params[:attempt_id])
    if @attempt.points.nil?
      @attempt.points = 0
    end
    @choice = Choice.find(params[:choice_id])
    @question = Question.find(params[:question_id])
    @quiz = @question.quiz
    if params[:team_id].present?
      @attempt_choice = AttemptChoice.new(attempt_id: @attempt.id, choice_id: @choice.id, question_id: @question.id, user_id: @user.id, team_id: @team.id)
    else
      @attempt_choice = AttemptChoice.new(attempt_id: @attempt.id, choice_id: @choice.id, question_id: @question.id, user_id: @user.id)
    end

    respond_to do |format|
      if @attempt_choice.save
        format.html { redirect_to quiz_attempt_path(@quiz.id, @attempt.id), notice: 'Attempt choice was successfully created.' }
        format.json { render :show, status: :created, location: @attempt_choice }
        format.js
        if @choice.correct? && @attempt.team_attempt?
          points = @attempt.points + team_points(@question)
          @attempt.points = points
          @attempt.save
        elsif @choice.correct?
          points = @attempt.points + 1
          @attempt.points = points
          @attempt.save
        end
      else
        format.html { render :new }
        format.json { render json: @attempt_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attempt_choices/1
  # PATCH/PUT /attempt_choices/1.json
  def update
    respond_to do |format|
      if @attempt_choice.update(attempt_choice_params)
        format.html { redirect_to @attempt_choice, notice: 'Attempt choice was successfully updated.' }
        format.json { render :show, status: :ok, location: @attempt_choice }
      else
        format.html { render :edit }
        format.json { render json: @attempt_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attempt_choices/1
  # DELETE /attempt_choices/1.json
  def destroy
    @attempt_choice.destroy
    respond_to do |format|
      format.html { redirect_to attempt_choices_url, notice: 'Attempt choice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attempt_choice
      @attempt_choice = AttemptChoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attempt_choice_params
      params.require(:attempt_choice).permit(:attempt_id, :question_id, :choice_id, :user_id, :team_id)
    end
end
