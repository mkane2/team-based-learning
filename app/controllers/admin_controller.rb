class AdminController < ApplicationController
  def dashboard
    if current_user.admin?
      print_user_attributes
      print_team_attributes
      print_quiz_attributes
      print_question_attributes
      @users = User.all
      @teams = Team.all
      @quizzes = Quiz.all
    else
      redirect_to root_url
    end
  end

  def print_user_attributes
    @user_attributes = User.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
      @user_attributes = filter_word_out("reset", @user_attributes)
      @user_attributes = filter_word_out("remember", @user_attributes)
      @user_attributes = filter_word_out("sign_in", @user_attributes)
      @user_attributes = filter_word_out("_at", @user_attributes)
      @user_attributes = filter_word_out("g>id", @user_attributes)
      @user_attributes = filter_word_out("encrypted", @user_attributes)
      @user_attributes = @user_attributes.push("<strong>password:</strong> string".html_safe)
  end

  def print_team_attributes
    @team_attributes = Team.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
      @team_attributes = filter_word_out("_at", @team_attributes)
      @team_attributes = filter_word_out("g>id", @team_attributes)
  end

  def print_quiz_attributes
    @quiz_attributes = Quiz.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
      @quiz_attributes = filter_word_out("_at", @quiz_attributes)
      @quiz_attributes = filter_word_out("g>id", @quiz_attributes)
  end

  def print_question_attributes
    @question_attributes = Question.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
      @question_attributes = filter_word_out("_at", @question_attributes)
      @question_attributes = filter_word_out("g>id", @question_attributes)
    @choice_attributes = Choice.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
      @choice_attributes = filter_word_out("_at", @choice_attributes)
      @choice_attributes = filter_word_out("_id", @choice_attributes)
      @choice_attributes = filter_word_out("g>id:", @choice_attributes)
  end

  def just_user_attributes
    @user_attributes = User.columns.collect { |c| "#{c.name}" }
      @user_attributes = filter_word_out("reset", @user_attributes)
      @user_attributes = filter_word_out("remember", @user_attributes)
      @user_attributes = filter_word_out("sign_in", @user_attributes)
      @user_attributes = filter_word_out("_at", @user_attributes)
      @user_attributes = filter_word_out("^id", @user_attributes)
      @user_attributes = filter_word_out("encrypted", @user_attributes)
      @user_attributes = @user_attributes.push("password".html_safe)
  end

  def just_team_attributes
    @team_attributes = Team.columns.collect { |c| "#{c.name}" }
      @team_attributes = filter_word_out("_at", @team_attributes)
      @team_attributes = filter_word_out("^id", @team_attributes)
  end

  def just_quiz_attributes
    @quiz_attributes = Quiz.columns.collect { |c| "#{c.name}" }
      @quiz_attributes = filter_word_out("_at", @quiz_attributes)
      @quiz_attributes = filter_word_out("^id", @quiz_attributes)
  end

  def just_question_attributes
    @question_attributes = Question.columns.collect { |c| "#{c.name}" }
      @question_attributes = filter_word_out("_at", @question_attributes)
      @question_attributes = filter_word_out("^id", @question_attributes)
    @choice_attributes = Choice.columns.collect { |c| "#{c.name}" }
      @choice_attributes = filter_word_out("_at", @choice_attributes)
      @choice_attributes = filter_word_out("_id", @choice_attributes)
      @choice_attributes = filter_word_out("^id", @choice_attributes)
    @question_attributes + @choice_attributes
  end

  def filter_word_out(word,array)
    array.delete_if { |data| data.match(word) }
    return array
  end

  def csv_template(model)
    require 'csv'
    if model == 'user'
      @filename = "tbl-user-template.csv"
      puts @filename
      CSV.generate_line just_user_attributes
    elsif model == 'team'
      @filename = "tbl-team-template.csv"
      CSV.generate_line just_team_attributes
    elsif model == 'quiz'
      @filename = "tbl-quiz-template.csv"
      CSV.generate_line just_quiz_attributes
    elsif model == 'question'
      @filename = "tbl-questions-template.csv"
      CSV.generate_line just_question_attributes
    end
  end

  # def download
  #   redirect_to admin_dashboard_path
  # end

  def index
    if params[:template].present?
      if params[:user].present?
        @download = csv_template('user')
      elsif params[:team].present?
        @download = csv_template('team')
      elsif params[:quiz].present?
        @download = csv_template('quiz')
      elsif params[:question].present?
        @download = csv_template('question')
      else
        redirect_to admin_dashboard_path, notice: "Sorry, that doesn't exist."
      end
    # elsif params[:generate].present?
    #   if params[:user].present?
    #     @download = csv_template('user')
    #   elsif params[:team].present?
    #     @download = csv_template('team')
    #   elsif params[:quiz].present?
    #     @download = csv_template('quiz')
    #   elsif params[:question].present?
    #     @download = csv_template('question')
    #   else
    #     redirect_to admin_dashboard_path, notice: "Sorry, that doesn't exist."
    #   end
    elsif params[:download].present?
      if params[:user].present?
        @download = download_csv('user')
      elsif params[:team].present?
        @download = download_csv('team')
      elsif params[:quiz].present?
        @download = download_csv('quiz')
      elsif params[:question].present?
        @download = download_csv('question')
      else
        redirect_to admin_dashboard_path, notice: "Sorry, that doesn't exist."
      end
    else
      @filename = "error.csv"
    end

    respond_to do |format|
      format.csv { send_data @download, filename: @filename }
    end
  end

  def generate_csv
  end

  def download_csv(model)
  end
end
