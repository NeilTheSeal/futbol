require "spec_helper"

RSpec.describe StatTracker do
  before(:all) do
    game_path = "./data/games.csv"
    team_path = "./data/teams.csv"
    game_teams_path = "./data/game_teams.csv"

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe "#initialize" do
    it "exists" do
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it "initializes from a CSV file" do
      expect(@stat_tracker.game_stats).to be_a(GameStats)
      expect(@stat_tracker.games).to all be_a(Game)
      expect(@stat_tracker.teams).to all be_a(Team)
      expect(@stat_tracker.game_teams).to all be_a(GameTeam)
    end
  end
end
