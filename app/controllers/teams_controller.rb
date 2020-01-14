class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    if user_signed_in? && current_user.admin?
      @teams = Team.all
    elsif user_signed_in?
      @course = current_user.enrolled_courses.first
      @teams = @course.teams
    else
      redirect_to root_url, notice: "Sorry, you need to sign in first."
    end
  end

  def import
    if current_user.admin?
      @errors = Team.batch_import(params[:file])
      if @errors.empty?
        redirect_to admin_dashboard_path, notice: "Teams successfully imported."
      else
        redirect_to admin_dashboard_path, notice: "#{@errors.join(", ")}"
      end
    else
      redirect_to root_url, notice: "Sorry, you can't do that."
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @attempts = @team.attempts
  end

  # GET /teams/new
  def new
    @team = Team.new
    @courses = Course.all
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_path(@team.name), notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find_by(name: params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :course_id)
    end
end
