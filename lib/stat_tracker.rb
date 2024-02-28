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
end
