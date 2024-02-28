require "CSV"
class Game
  def initialize(details)
    @game_id = details[:game_id]
    @away_goals = details[:away_goals].to_i
    @home_goals = details[:home_goals].to_i

  end

  def self.create_games(csv_file_path)
    games_list = []
    CSV.foreach(
      csv_file_path,
      headers: true,
      header_converters: :symbol
    ) do |row|
      games_list << Game.new(row)
    end
    games_list
  end

  # def highest_total_score
  #   goals_scored = total_score
  #   @games.each do |game|
  #     game.max_by |home_goal| 
  #     goals_scored << home_goal
  #     goals_scored << away_goals
  #   end
  # end


  def total_score
    @away_goals + @home_goals
  end
end

