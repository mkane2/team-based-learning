module AttemptsHelper
  def outline_button
    @outline_button_classes = ["btn-outline-primary", "btn-outline-success", "btn-outline-info", "btn-outline-warning", "btn-outline-danger", "btn-outline-primary", "btn-outline-success", "btn-outline-info", "btn-outline-warning", "btn-outline-danger", "btn-outline-primary", "btn-outline-success", "btn-outline-info", "btn-outline-warning", "btn-outline-danger", "btn-outline-primary", "btn-outline-success", "btn-outline-info", "btn-outline-warning", "btn-outline-danger", "btn-outline-primary", "btn-outline-success", "btn-outline-info", "btn-outline-warning", "btn-outline-danger", "btn-outline-primary", "btn-outline-success", "btn-outline-info", "btn-outline-warning", "btn-outline-danger", "btn-outline-primary", "btn-outline-success", "btn-outline-info", "btn-outline-warning", "btn-outline-danger"]
  end

  def individual_points_possible(question)
    @total = question.choices.size.to_s
  end

  def individual_points(question)
    @total = question.choices.size
    @attempts = current_user.attempt_choices.where(question_id: question.id).count
    @possible = @total - @attempts + 1
    @possible.to_s
  end

  def team_points(question)
    @total = question.choices.size
    @attempts = current_user.team.attempt_choices.where(question_id: question.id).count
    @possible = @total - @attempts
    @possible.to_s
  end

  def team_points_possible(question)
    @total = question.choices.size
    @attempts = current_user.team.attempt_choices.where(question_id: question.id).count
    @possible = @total - @attempts
    @possible.to_s
  end

  def score_points(question)
    @total = question.choices.size
    @attempts = current_user.attempt_choices.where(question_id: question.id).where(team_id: nil).size
    @possible = @total - @attempts + 1
  end

  def correct_class(choice, attempt)
    if attempt.team_attempt? && choice.correct? && attempt.team_id.present?
      "btn-success"
    elsif choice.attempt_choices.where(user_id: current_user.id).present? && attempt.team_attempt == false
      "btn-info"
    elsif choice.correct? && attempt.team_id.present?
      "btn-success"
    else
      "btn-secondary"
    end
  end

  def results_helper(choice)
    if choice.attempt_choices.where(user_id: current_user.id).where(team_id: nil).present?
      if choice.correct?
        '<span class="badge badge-info response">✓</span></br>'.html_safe
      else
        '<span class="badge badge-danger response">X</span></br>'.html_safe
      end
    end
  end
end
