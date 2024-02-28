require "CSV"
class Game
  def initialize(details)
    @game_id = details[:game_id]
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
