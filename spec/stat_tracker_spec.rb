require "spec_helper"

RSpec.describe StatTracker do
  before(:all) do
    game_path = "./data/games_fixture.csv"
    team_path = "./data/teams_fixture.csv"
    game_teams_path = "./data/game_teams_fixture.csv"

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
      expect(@stat_tracker.stat_generator).to be_a(StatGenerator)
      expect(@stat_tracker.games).to all be_a(Game)
      expect(@stat_tracker.teams).to all be_a(Team)
      expect(@stat_tracker.game_teams).to all be_a(GameTeam)
    end
  end
end
