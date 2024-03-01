require "spec_helper"

RSpec.describe Game do
  before(:all) do
    @games = Game.create_games("./data/games_fixture.csv")
  end

  before(:each) do
    @game1 = @games[0]
  end

  describe "#initialize" do
    it "exists" do
      expect(@game1).to be_a(Game)
    end
  end

  describe "::create_games" do
    it "creates Game instances from a CSV file" do
      expect(@games).to all be_a(Game)
    end
  end

  describe '#total_score' do
    it 'gets the total score of the game' do
      expect(@game1.total_score).to eq(5)
    end
  end
end
