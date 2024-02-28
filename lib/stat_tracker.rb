class StatTracker
  attr_reader :game_stats, :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @game_stats = GameStats.new(@games, @teams, @game_teams)
  end

  def self.from_csv(locations)
    games = Game.create_games(locations[:games])
    teams = Team.create_teams(locations[:teams])
    game_teams = GameTeam.create_game_teams(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end
end
