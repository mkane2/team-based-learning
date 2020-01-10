module QuizzesHelper

  def progress_helper(quiz, team)
    @total = quiz.questions.size
    @team_attempt = quiz.attempts.where(team_id: team.id).first
    if @team_choices_made = @team_attempt.present?
      @team_choices_made = @team_attempt.attempt_choices.where(team_id: team.id)
      @team_progress = @team_choices_made.includes(:question).uniq.size.to_f
      percent = @team_progress / @total.to_f
      percent = percent * 100
      percent.to_s
    else
      0
    end
  end

  def animation_helper(quiz, team)
    if progress_helper(quiz, team).to_f < 100
      'progress-bar-striped progress-bar-animated'
    else
      
    end
  end

  def individual_quiz_percent(quiz)
    score = quiz.attempts.where(user_id: current_user.id).where(team_id: nil).first.points.to_f
    puts score
    total = quiz.questions.size.to_f
    puts total
    percent = score / total
    percent * 100
  end

  def team_quiz_percent(quiz)
    score = quiz.attempts.where(team_id: current_user.team.id).first.points.to_f
    total = quiz.questions.joins(:choices).size.to_f
    percent = score / total
    percent * 100
  end
end
