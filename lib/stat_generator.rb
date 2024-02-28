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

  def coaches
    coach_list = []
    @game_teams.each do |game_team|
      unless coach_list.include?(game_team.coach)
        coach_list.push(game_team.coach)
      end
    end
    coach_list
  end

  def coaches_by_season
    coach_list = {}
    seasons.each { |season| coach_list[season.to_sym] = [] }
    game_team_by_season.each do |season, game_team_list|
      game_team_list.each do |game_team|
        unless coach_list[season].include?(game_team.coach)
          coach_list[season].push(game_team.coach)
        end
      end
    end
    coach_list
  end

  def winningest_coach(season)
    game_teams_list = game_team_by_season[season.to_sym]
    wins_by_coach = {}
    coaches_by_season[season.to_sym].each do |coach|
      wins_by_coach[coach.to_sym] = 0
    end
    game_teams_list.each do |game_team|
      wins_by_coach[game_team.coach.to_sym] += 1 if game_team.result == "WIN"
    end
    wins_by_coach.max_by { |_coach, wins| wins }[0].to_s
  end
end
