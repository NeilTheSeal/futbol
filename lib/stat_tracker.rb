require_relative "./helper_class"

class StatTracker
  attr_reader :stat_generator, :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @stat_generator = StatGenerator.new(@games, @teams, @game_teams)
  end

  def self.from_csv(locations)
    games = Game.create_games(locations[:games])
    teams = Team.create_teams(locations[:teams])
    game_teams = GameTeam.create_game_teams(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def highest_total_score
    @stat_generator.highest_total_score
  end

  def lowest_total_score
    @stat_generator.lowest_total_score
  end

  def percentage_home_wins
    @stat_generator.percentage_home_wins
  end

  def percentage_visitor_wins
    @stat_generator.percentage_visitor_wins
  end

  def percentage_ties
    @stat_generator.percentage_ties
  end

  def count_of_games_by_season
    @stat_generator.count_of_games_by_season
  end

  def average_goals_per_game
    @stat_generator.average_goals_per_game
  end

  def average_goals_by_season
    @stat_generator.average_goals_by_season
  end

  def count_of_teams
    @stat_generator.count_of_teams
  end

  def best_offense
    @stat_generator.best_offense
  end

  def worst_offense
    @stat_generator.worst_offense
  end

  def highest_scoring_visitor
    @stat_generator.highest_scoring_visitor
  end

  def lowest_scoring_visitor
    @stat_generator.lowest_scoring_visitor
  end

  def highest_scoring_home_team
    @stat_generator.highest_scoring_home_team
  end

  def lowest_scoring_home_team
    @stat_generator.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @stat_generator.winningest_coach(season)
  end

  def worst_coach(season)
    @stat_generator.worst_coach(season)
  end

  def most_accurate_team(season)
    @stat_generator.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @stat_generator.least_accurate_team(season)
  end

  def most_tackles(season)
    @stat_generator.most_tackles(season)
  end

  def fewest_tackles(season)
    @stat_generator.fewest_tackles(season)
  end
end
