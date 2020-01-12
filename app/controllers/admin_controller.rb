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
      @questions = Question.all
    else
      redirect_to root_url
    end
  end

  def upload_create(model)
    model.constantize.batch_import(params[:file])
    redirect_to admin_dashboard_path, notice: "#{[:model].capitalize} successfully imported"
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
      @quiz_attributes = filter_word_out("user_id", @quiz_attributes)
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
      # puts @user_attributes
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
      @quiz_attributes = filter_word_out("user_id", @quiz_attributes)
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
      @csv = CSV.open(@filename, "w") do |csv|
        csv << just_user_attributes
      end
      @filename
    elsif model == 'team'
      @filename = "tbl-team-template.csv"
      @csv = CSV.open(@filename, "w") do |csv|
        csv << just_team_attributes
      end
      @filename
    elsif model == 'quiz'
      @filename = "tbl-quiz-template.csv"
      @csv = CSV.open(@filename, "w") do |csv|
        csv << just_quiz_attributes
      end
      @filename
    elsif model == 'question'
      @filename = "tbl-question-template.csv"
      @csv = CSV.open(@filename, "w") do |csv|
        csv << just_question_attributes
      end
      @filename
    end
  end

  def index
    if current_user.admin?
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
      elsif params[:upload].present?
        if params[:user].present?
          upload_create('user')
        elsif params[:team].present?
          upload_create('team')
        elsif params[:quiz].present?
          upload_create('quiz')
        elsif params[:question].present?
          upload_create('question')
        else
          redirect_to admin_dashboard_path, notice: "Sorry, that doesn't exist."
        end
      else
        @filename = "error.csv"
      end

      respond_to do |format|
        format.csv { send_file @download, filename: @filename }
      end
    else
      redirect_to root_url
    end
  end

  def download_csv(model)
    require 'csv'
    if model == 'user'
      @filename = "tbl-user-results.csv"
      @users = User.all

      @quizzes = Quiz.all
      @quiz_attributes = []
      @quizzes.each_with_index do |quiz, index|
        @quiz_attributes << "#{quiz.id}: Ind #{quiz.name}"
        @quiz_attributes << "#{quiz.id}: Team #{quiz.name}"
      end

      @header_line = just_user_attributes + @quiz_attributes
      @csv = CSV.open(@filename, "w") do |csv|
        csv << @header_line
      end

      @users.each do |user|
        @user_attributes = []
        if user.team.present?
          @team_name = user.team.name
        else
          ""
        end
        @user_attributes << "#{user.email}"
        @user_attributes << "#{user.admin}"
        @user_attributes << "#{user.username}"
        @user_attributes << "#{user.team_id}"
        @user_attributes << "#{@team_name}"
        @user_attributes << "#{user.studentid}"
        @user_attributes << "#{user.firstname}"
        @user_attributes << "#{user.lastname}"

        @quiz_attributes = []
        @quizzes.each do |quiz|
          if Attempt.where(quiz_id: quiz.id, user_id: user.id, team_attempt: false).present?
            @quiz_attributes << Attempt.where(quiz_id: quiz.id, user_id: user.id, team_attempt: false).first.points
          else
            @quiz_attributes << ""
          end
          if user.team.present? && Attempt.where(quiz_id: quiz.id, team_id: user.team.id, team_attempt: true).present?
            @quiz_attributes << Attempt.where(quiz_id: quiz.id, team_id: user.team.id, team_attempt: true).first.points
          else
            @quiz_attributes << ""
          end
        end
        @user_attributes = @user_attributes + @quiz_attributes
        @csv = CSV.open(@filename, "ab") do |csv|
          csv << @user_attributes
        end
      end

      @filename
    elsif model == 'team'
      @filename = "tbl-team-results.csv"
      CSV.generate_line just_team_attributes
    elsif model == 'quiz'
      @filename = "tbl-quiz-results.csv"
      CSV.generate_line just_quiz_attributes
    elsif model == 'question'
      @filename = "tbl-questions-results.csv"
      CSV.generate_line just_question_attributes
    end
  end
end
