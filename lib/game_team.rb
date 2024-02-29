class GameTeam
  attr_reader :team_id, :game_id, :coach, :result, :goals, :home_or_away

  def initialize(details)
    @team_id = details[:team_id]
    @game_id = details[:game_id]
    @coach = details[:head_coach]
    @result = details[:result]
    @goals = details[:goals].to_i
    @home_or_away = details[:hoa]
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
