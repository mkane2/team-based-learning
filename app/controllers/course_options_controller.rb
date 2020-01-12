class CourseOptionsController < ApplicationController
  before_action :set_course_option, only: [:show, :edit, :update, :destroy]

  # GET /course_options
  # GET /course_options.json
  def index
    @course_options = CourseOption.all
  end

  # GET /course_options/1
  # GET /course_options/1.json
  def show
  end

  # GET /course_options/new
  def new
    @course_option = CourseOption.new
  end

  # GET /course_options/1/edit
  def edit
  end

  # POST /course_options
  # POST /course_options.json
  def create
    @course_option = CourseOption.new(course_option_params)

    respond_to do |format|
      if @course_option.save
        format.html { redirect_to @course_option, notice: 'Course option was successfully created.' }
        format.json { render :show, status: :created, location: @course_option }
      else
        format.html { render :new }
        format.json { render json: @course_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_options/1
  # PATCH/PUT /course_options/1.json
  def update
    respond_to do |format|
      if @course_option.update(course_option_params)
        format.html { redirect_to @course_option, notice: 'Course option was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_option }
      else
        format.html { render :edit }
        format.json { render json: @course_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_options/1
  # DELETE /course_options/1.json
  def destroy
    @course_option.destroy
    respond_to do |format|
      format.html { redirect_to course_options_url, notice: 'Course option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_option
      @course_option = CourseOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_option_params
      params.require(:course_option).permit(:randomize_questions, :randomize_answers, :show_all_questions, :active, :duration, :course_id, :user_id)
    end
end
