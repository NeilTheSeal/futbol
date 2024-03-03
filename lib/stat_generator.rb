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
    (total_home_wins / count_of_games.to_f).round(2)
  end

  def total_away_wins
    @games.count do |game|
      game.away_goals > game.home_goals
    end
  end

  def percentage_away_wins
    (total_away_wins / count_of_games.to_f).round(2)
  end

  def total_ties
    @games.count do |game|
      game.away_goals == game.home_goals
    end
  end

  def percentage_ties
    (total_ties / count_of_games.to_f).round(2)
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

  def shots_and_goals_by_id_and_season # rubocop:disable Metrics/MethodLength
    list = {}
    seasons.each { |season| list[season.to_sym] = {} }
    game_team_by_season.each do |season, game_team_array|
      game_team_array.each do |game_team|
        if list[season][game_team.team_id.to_sym].nil?
          list[season][game_team.team_id.to_sym] = {
            shots: game_team.shots,
            goals: game_team.goals
          }
        else
          list[season][game_team.team_id.to_sym][:shots] += game_team.shots
          list[season][game_team.team_id.to_sym][:goals] += game_team.goals
        end
      end
    end
    list
  end

  def most_accurate_team(season)
    team_and_ratio = {}
    shots_and_goals = shots_and_goals_by_id_and_season[season.to_sym]
    shots_and_goals.each do |team_id, shot_goal|
      team_and_ratio[team_id] = shot_goal[:goals].to_f / shot_goal[:shots]
    end
    team_id = team_and_ratio.max_by { |_id, ratio| ratio }[0]
    @teams.find do |team|
      team.team_id == team_id.to_s
    end.team_name
  end

  def least_accurate_team(season)
    team_and_ratio = {}
    shots_and_goals = shots_and_goals_by_id_and_season[season.to_sym]
    shots_and_goals.each do |team_id, shot_goal|
      team_and_ratio[team_id] = shot_goal[:goals].to_f / shot_goal[:shots]
    end
    team_id = team_and_ratio.min_by { |_id, ratio| ratio }[0]
    @teams.find do |team|
      team.team_id == team_id.to_s
    end.team_name
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

  def coach_evaluation(season, winner_or_loser)
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
    coach_evaluation(season, "winner")
  end

  def worst_coach(season)
    coach_evaluation(season, "loser")
  end

  def count_of_teams
    @teams.count
  end

  def total_games_played_by_team(team_id, home_or_away = "all")
    @game_teams.count do |game_team|
      if home_or_away == "away"
        game_team.team_id == team_id && game_team.home_or_away == "away"
      elsif home_or_away == "home"
        game_team.team_id == team_id && game_team.home_or_away == "home"
      else
        game_team.team_id == team_id
      end
    end
  end

  def total_goals_by_team(team_id, home_or_away = "all")
    @game_teams.sum do |game_team|
      if home_or_away == "away"
        (if game_team.team_id == team_id && game_team.home_or_away == "away"
           game_team.goals
         end).to_i
      elsif home_or_away == "home"
        (if game_team.team_id == team_id && game_team.home_or_away == "home"
           game_team.goals
         end).to_i
      else
        (game_team.goals if game_team.team_id == team_id).to_i
      end
    end
  end

  def average_goals_per_game_by_team(team_id, home_or_away = "all")
    if home_or_away == "away"
      (total_goals_by_team(team_id,
                           home_or_away).to_f / total_games_played_by_team(
                             team_id, home_or_away
                           )).round(2)
    elsif home_or_away == "home"
      (total_goals_by_team(team_id,
                           home_or_away).to_f / total_games_played_by_team(
                             team_id, home_or_away
                           )).round(2)
    else
      (total_goals_by_team(team_id).to_f / total_games_played_by_team(team_id)).round(2)
    end
  end

  def best_offense
    @teams.max_by do |team|
      average_goals_per_game_by_team(team.team_id)
    end.team_name
  end

  def highest_scoring_visitor
    @teams.max_by do |team|
      average_goals_per_game_by_team(team.team_id, "away")
    end.team_name
  end

  def highest_scoring_home_team
    @teams.max_by do |team|
      average_goals_per_game_by_team(team.team_id, "home")
    end.team_name
  end

  def worst_offense
    @teams.min_by do |team|
      average_goals_per_game_by_team(team.team_id)
    end.team_name
  end

  def lowest_scoring_visitor
    @teams.min_by do |team|
      average_goals_per_game_by_team(team.team_id, "away")
    end.team_name
  end

  def lowest_scoring_home_team
    @teams.min_by do |team|
      average_goals_per_game_by_team(team.team_id, "home")
    end.team_name
  end
end
