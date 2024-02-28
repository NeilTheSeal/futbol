require "spec_helper"

RSpec.describe StatGenerator do
  before(:all) do
    @games = Game.create_games("./data/games.csv")
    @game_teams = GameTeam.create_game_teams("./data/game_teams.csv")
    @teams = Team.create_teams("./data/teams.csv")
  end

  before(:each) do
    @stat_generator = StatGenerator.new(@games, @teams, @game_teams)
  end

  describe "#initialize" do
    it "exists" do
      expect(@stat_generator).to be_a(StatGenerator)
    end

    it "has attributes" do
      expect(@stat_generator.games).to eq(@games)
      expect(@stat_generator.teams).to eq(@teams)
      expect(@stat_generator.game_teams).to eq(@game_teams)
    end
  end

  describe "#helper methods" do
    it "can list seasons" do
      seasons = %w[20122013 20162017 20142015 20152016 20132014 20172018]
      expect(@stat_generator.seasons).to eq(seasons)
    end
  end
end
