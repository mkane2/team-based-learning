class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:name])
    if @user.team.present?
      @team = @user.team
    end
  end

  def index
  end

  def admin_dashboard
    if current_user.admin?
      @user = current_user
      @user_attributes = User.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
        @user_attributes = filter_word_out("reset", @user_attributes)
        @user_attributes = filter_word_out("remember", @user_attributes)
        @user_attributes = filter_word_out("sign_in", @user_attributes)
        @user_attributes = filter_word_out("_at", @user_attributes)
        @user_attributes = filter_word_out("g>id", @user_attributes)
        @user_attributes = filter_word_out("encrypted", @user_attributes)
        @user_attributes = @user_attributes.push("<strong>password:</strong> string".html_safe)
      @quiz_attributes = Quiz.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
        @quiz_attributes = filter_word_out("_at", @quiz_attributes)
        @quiz_attributes = filter_word_out("g>id", @quiz_attributes)
      @question_attributes = Question.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
        @question_attributes = filter_word_out("_at", @question_attributes)
        @question_attributes = filter_word_out("g>id", @question_attributes)
      @choice_attributes = Choice.columns.collect { |c| "<strong>#{c.name}:</strong> #{c.type}".html_safe }
        @choice_attributes = filter_word_out("_at", @choice_attributes)
        @choice_attributes = filter_word_out("_id", @choice_attributes)
        @choice_attributes = filter_word_out("id:", @choice_attributes)
    else
      redirect_to root_url
    end
  end

  def filter_word_out(word,array)
    array.delete_if { |data| data.match(word) }
    return array
  end

  def dashboard
    @user = current_user
    @courses = Course.all
    @enrollment = current_user.enrollments.build
  end
end
