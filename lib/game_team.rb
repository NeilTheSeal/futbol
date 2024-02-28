class GameTeam
  attr_reader :game_id, :coach, :result

  def initialize(details)
    @game_id = details[:game_id]
    @coach = details[:head_coach]
    @result = details[:result]
  end

  def self.create_game_teams(csv_file_path)
    game_teams_list = []
    CSV.foreach(
      csv_file_path,
      headers: true,
      header_converters: :symbol
    ) do |row|
      game_teams_list << GameTeam.new(row)
    end
    game_teams_list
  end
end
