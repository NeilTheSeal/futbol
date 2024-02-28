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

  describe '#highest total score' do
    it 'Calculates the highest total score for all games' do
      expect(@stat_generator.highest_total_score).to eq(11)
      # @game2 = Game.new() try to prove that 
      expect(@stat_generator.highest_total_score).to_not eq(1)
    end
  end
end
