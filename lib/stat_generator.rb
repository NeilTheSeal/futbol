class StatGenerator
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def count_of_teams
    @teams.count
  end

  def total_games_played_by_team(team_id)
    @game_teams.count do |game_team|
      game_team.team_id == team_id
    end
  end

  def total_goals_by_team(team_id)
    @game_teams.sum do |game_team|
      if game_team.team_id == team_id
        game_team.goals
      else
        0
      end
    end
  end
end
