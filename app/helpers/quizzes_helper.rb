module QuizzesHelper

  def duedate_helper(quiz)
    if current_user.admin? && quiz.due_date < Time.now.to_datetime
      'btn-info'
    elsif quiz.due_date < Time.now.to_datetime
      'btn-info'
    else
      'btn-outline-info'
    end
  end

  def lastasc_order_helper(sort)
    if sort == 'lastasc'
      "btn-primary"
    else
      "btn-outline-primary"
    end
  end

  def lastdesc_order_helper(sort)
    if sort == 'lastdesc'
      "btn-primary"
    else
      "btn-outline-primary"
    end
  end

  def individualasc_order_helper(sort)
    if sort == 'individualasc'
      "btn-primary"
    else
      "btn-outline-primary"
    end
  end

  def individualdesc_order_helper(sort)
    if sort == 'individualdesc'
      "btn-primary"
    else
      "btn-outline-primary"
    end
  end

  def team_order_helper(sort)
    if sort == 'team'
      "btn-primary"
    else
      "btn-outline-primary"
    end
  end

  def teamasc_order_helper(sort)
    if sort == 'teamasc'
      "btn-primary"
    else
      "btn-outline-primary"
    end
  end

  def teamdesc_order_helper(sort)
    if sort == 'teamdesc'
      "btn-primary"
    else
      "btn-outline-primary"
    end
  end

  def duedate(quiz)
    quiz.due_date.strftime("%A, %B %e at %l:%M%p")
  end

  def progress_helper(quiz, team)
    @total = quiz.questions.size
    puts "total: #{@total}"
    @team_attempt = quiz.attempts.where(team_id: team.id, team_attempt: true).first
    if @team_attempt.present?
      @team_choices_made = @team_attempt.attempt_choices.where(team_id: team.id)
      puts "team_choices_made #{@team_choices_made}"
      @team_progress = @team_choices_made.map(&:question).compact.uniq.count.to_f
      puts "team_progress #{@team_progress}"
      percent = ( @team_progress / @total.to_f ) * 100
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

  def my_results(quiz)
    if quiz.attempts.where(user_id: current_user.id).where(team_id: nil).present? && quiz.attempts.where(team_id: current_user.team.id).present?
      "#{quiz.attempts.where(user_id: current_user.id, team_attempt: false).first.points} /
    #{number_to_percentage quiz.attempts.where(user_id: current_user.id, team_attempt: false).first.points.to_f / quiz.questions.count.to_f * 100, precision: 0}".to_s
    else
      "Team must complete quiz"
    end
  end
end
