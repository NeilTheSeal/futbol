require "CSV"
class Game
  attr_reader :game_id,
              :season

  def initialize(details)
    @game_id = details[:game_id]
    @season = details[:season]
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
end
