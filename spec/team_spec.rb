require "spec_helper"

RSpec.describe Team do
  before(:all) do
    @teams = Team.create_teams("./data/teams_fixture.csv")
  end

  before(:each) do
    @team1 = @teams[0]
  end

  describe "#initialize" do
    it "exists" do
      expect(@team1).to be_a(Team)
    end

    it "has a team_id" do
      expect(@team1.team_id).to eq("19")
    end

    it "has a name" do
      expect(@team1.team_name).to eq("Philadelphia Union")
    end
  end

  describe "::create_teams" do
    it "creates Team instances from a CSV file" do
      expect(@teams).to all be_a(Team)
    end
  end
end
