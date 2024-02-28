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

  describe "#count_of_teams" do
    it "can count the number of teams" do
      count = @stat_generator.count_of_teams

      expect(count).to be_a(Integer)

      details = Hash.new(nil)
      @teams << Team.new(details)
      new_count = @stat_generator.count_of_teams

      expect(new_count).to eq(count += 1)
    end
  end
end
