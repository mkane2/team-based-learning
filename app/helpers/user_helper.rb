module UserHelper
  def my_average
    current_user.attempts.where(team_attempt: false).map(&:points).sum.to_f / all_points.to_f * 100
  end

  def all_points
    points = []
    current_user.attempts.each do |attempt|
      points << attempt.quiz.questions.count
    end
    points.sum
  end

  def my_team_average
    current_user.team.attempts.where(team_attempt: true).map(&:points).sum.to_f / all_team_points.to_f * 100
  end

  def all_team_points
    points = []
    current_user.team.attempts.each do |attempt|
      points << attempt.quiz.choices.count
    end
    points.sum
  end
end
