require "CSV"
class Game

  attr_reader :away_goals, :home_goals
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

  def total_score
    @away_goals + @home_goals
  end
end

