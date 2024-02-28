require "spec_helper"

RSpec.describe GameStats do
  before(:all) do
    @games = Game.create_games("./data/games.csv")
    @game_teams = GameTeam.create_game_teams("./data/game_teams.csv")
    @teams = Team.create_teams("./data/teams.csv")
  end

  before(:each) do
    @game_stats = GameStats.new(@games, @teams, @game_teams)
  end

  describe "#initialize" do
    it "exists" do
      expect(@game_stats).to be_a(GameStats)
    end

    it "has attributes" do
      expect(@game_stats.games).to eq(@games)
      expect(@game_stats.teams).to eq(@teams)
      expect(@game_stats.game_teams).to eq(@game_teams)
    end
  end
end
