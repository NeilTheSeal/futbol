class Team
  attr_reader :team_id, :team_name

  def initialize(details)
    @team_id = details[:team_id]
    @team_name = details[:teamname]
  end

  def self.create_teams(csv_file_path)
    teams_list = []
    CSV.foreach(
      csv_file_path,
      headers: true,
      header_converters: :symbol
    ) do |row|
      teams_list << Team.new(row)
    end
    teams_list
  end
end
