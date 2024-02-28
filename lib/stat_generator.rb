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
    season_id_list = generate_array_hash(seasons)
    @games.each do |game|
      unless season_id_list[game.season.to_sym].include?(game.game_id)
        season_id_list[game.season.to_sym].push(game.game_id)
      end
    end
    season_id_list
  end

  def generate_array_hash(keys)
    hash = {}
    keys.each { |key| hash[key.to_sym] = [] }
    hash
  end

  def generate_integer_hash(keys)
    hash = {}
    keys.each { |key| hash[key.to_sym] = 0 }
    hash
  end

  def game_team_by_season
    season_game_list = generate_array_hash(seasons)
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
    coach_list = generate_array_hash(seasons)
    game_team_by_season.each do |season, game_team_list|
      game_team_list.each do |game_team|
        unless coach_list[season].include?(game_team.coach)
          coach_list[season].push(game_team.coach)
        end
      end
    end
    coach_list
  end

  def best_worst_coach(season, winner_or_loser)
    game_teams_list = game_team_by_season[season.to_sym]
    wins_by_coach = generate_integer_hash(coaches_by_season[season.to_sym])
    game_teams_list.each do |game_team|
      wins_by_coach[game_team.coach.to_sym] += 1 if game_team.result == "WIN"
    end
    if winner_or_loser == "winner"
      wins_by_coach.max_by { |_coach, wins| wins }[0].to_s
    else
      wins_by_coach.min_by { |_coach, wins| wins }[0].to_s
    end
  end

  def winningest_coach(season)
    best_worst_coach(season, "winner")
  end

  def worst_coach(season)
    best_worst_coach(season, "loser")
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
