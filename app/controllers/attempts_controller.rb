class AttemptsController < ApplicationController
  before_action :set_attempt, only: [:show, :edit, :update, :destroy]

  # GET /attempts
  # GET /attempts.json
  def index
    @attempts = Attempt.all
  end

  # GET /attempts/1
  # GET /attempts/1.json
  def show
    @quiz = Quiz.find(params[:quiz_id])
    @questions = @quiz.questions
    @choices = Choice.joins(:question).merge(@questions).uniq
    @points_possible = @choices.size
    if params[:results].present? && current_user.team.attempts.where(quiz_id: params[:quiz_id]).present?
      @results = true
      @team_attempt = @quiz.attempts.where(team_attempt: true, team_id: current_user.team.id).first
      @individual_attempt = @quiz.attempts.where(team_attempt: false, user_id: current_user.id).first
    end
  end

  # GET /attempts/new
  def new
    @quiz = Quiz.find(params[:quiz_id])
    @attempt = @quiz.attempts.build
  end

  # GET /attempts/1/edit
  def edit
  end

  # POST /attempts
  # POST /attempts.json
  def create
    @user = current_user
    @team = current_user.team
    @quiz = Quiz.find(params[:quiz_id])
    if params[:team].present?
      @attempt = Attempt.new(user_id: @user.id, quiz_id: params[:quiz_id], team_id: @team.id, team_attempt: true)
    else
      @attempt = Attempt.new(user_id: @user.id, quiz_id: params[:quiz_id], team_id: nil, team_attempt: false)
    end
    respond_to do |format|
      if @attempt.save
        format.html { redirect_to quiz_attempt_path(@quiz.id, @attempt.id), notice: 'Quiz started.' }
        format.json { render :show, status: :created, location: @attempt }
      else
        format.html { render :new, notice: @attempt.errors }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attempts/1
  # PATCH/PUT /attempts/1.json
  def update
    respond_to do |format|
      if @attempt.update(attempt_params)
        format.html { redirect_to @attempt, notice: 'attempt was successfully updated.' }
        format.json { render :show, status: :ok, location: @attempt }
      else
        format.html { render :edit }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attempts/1
  # DELETE /attempts/1.json
  def destroy
    @attempt.destroy
    respond_to do |format|
      format.html { redirect_to attempts_url, notice: 'Quiz attempt was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attempt
      @attempt = Attempt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attempt_params
      params.require(:attempt).permit(:user_id, :team_id, :quiz_id, :team_attempt, :points)
    end
end
