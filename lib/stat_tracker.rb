class StatTracker
  def initialize; end

  def self.from_csv(locations)
    game_path = locations[:games]
    teams_path = locations[:teams]
    game_teams_path = locations[:game_teams]
    StatTracker.new
  end
end
