class StatGenerator
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def seasons
    seasons = []
    @games.each do |game|
      seasons.push(game.season) unless seasons.include?(game.season)
    end
    seasons
  end

  def id_by_season
    season_id_list = {}
    seasons.each { |season| season_id_list[season.to_sym] = [] }
    @games.each do |game|
      unless season_id_list[game.season.to_sym].include?(game.game_id)
        season_id_list[game.season.to_sym].push(game.game_id)
      end
    end
    season_id_list
  end

  def game_team_by_season
    season_game_list = {}
    seasons.each { |season| season_game_list[season.to_sym] = [] }
    @game_teams.each do |game_team|
      @games.each do |game|
        next unless game_team.game_id == game.game_id

        season_game_list[game.season.to_sym].push(game_team)
      end
    end
    season_game_list
  end
end
