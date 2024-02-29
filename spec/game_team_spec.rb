require "spec_helper"

RSpec.describe GameTeam do
  before(:all) do
    @game_teams = GameTeam.create_game_teams("./data/game_teams.csv")
  end

  before(:each) do
    @game_team1 = @game_teams[0]
  end

  describe "#initialize" do
    it "exists" do
      expect(@game_team1).to be_a(GameTeam)
    end

    it "has a team_id" do
      expect(@game_team1.team_id).to eq("3")
    end

    it "has goals" do
      expect(@game_team1.goals).to eq(2)
    end

    it "can be the away team" do
      expect(@game_team1.home_or_away).to eq("away")
    end

    it "can be the home team" do
      @game_team2 = @game_teams[1]

      expect(@game_team2.home_or_away).to eq("home")
    end
  end

  describe "::create_game_teams" do
    it "creates GameTeam instances from a CSV file" do
      expect(@game_teams).to all be_a(GameTeam)
    end
  end
end
