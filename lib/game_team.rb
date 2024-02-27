class GameTeam
  def initialize(details)
    @game_id = details[:game_id]
  end

  def self.create_game_teams(csv_file_path)
    game_teams_list = []
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row|
        game_teams_list << GameTeam.new(row)
    end
    game_teams_list
  end
end