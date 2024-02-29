class StatGenerator
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def highest_total_score
    @games.max_by do |game|
      game.total_score
    end.total_score
  end

  def lowest_total_score 
    @games.min_by do |game| 
      game.total_score
    end.total_score
  end

  def count_of_games
    @games.count 
  end

  def total_home_wins
   @games.count do |game|
     game.home_goals > game.away_goals
   end
 end

 def percentage_home_wins
  (total_home_wins / count_of_games.to_f ).round(2)
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

  def average_goals_per_game_by_team(team_id)
    (total_goals_by_team(team_id).to_f /
    total_games_played_by_team(team_id)).round(2)
  end

  def best_offense
    @teams.max_by do |team|
      average_goals_per_game_by_team(team.team_id)
    end.team_name
  end

  def worst_offense
    @teams.min_by do |team|
      average_goals_per_game_by_team(team.team_id)
    end.team_name
  end
end
