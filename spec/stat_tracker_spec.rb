require "spec_helper"

# rubocop:disable Metrics/BlockLength
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

  describe "#checks highest total score and lowest total score" do
    it "Calculates the highest total score for all games" do
      expect(@stat_tracker.highest_total_score).to eq(7)
    end

    it "Calculates the lowest total score of all games" do
      expect(@stat_tracker.lowest_total_score).to eq(3)
    end
  end

  describe "#percent wins at home " do
    it "Sees the percent won at home " do
      expect(@stat_tracker.percentage_home_wins).to eq(0.57)
    end
  end

  describe "#percent wins visitor " do
    it "Sees the percent won visitor " do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end
  end

  describe "#percent ties " do
    it "Sees the percent of how many games they had a tie" do
      expect(@stat_tracker.percentage_ties).to eq(0.07)
    end
  end

  describe "#count of games by season" do
    it "count all games per season" do
      expected = {
        "20162017" => 6,
        "20142015" => 8
      }
      expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end

  describe "#average goals per game " do
    it "calculates average goals per game " do
      expect(@stat_tracker.average_goals_per_game).to eq(4.21)
    end
  end

  describe "#average goals by season" do
    it "calculates the average goals each season" do
      expected = {
        "20162017" => 4.0,
        "20142015" => 4.38
      }
      expect(@stat_tracker.average_goals_by_season).to eq(expected)
    end
  end

  describe "#count_of_teams" do
    it "can count the number of teams" do
      count = @stat_tracker.count_of_teams

      expect(count).to be_a(Integer)

      details = Hash.new(0)
      @stat_tracker.teams << Team.new(details)
      new_count = @stat_tracker.count_of_teams

      expect(new_count).to eq(count + 1)

      @stat_tracker.teams.pop
    end
  end

  describe "#best_offense" do
    it "can return the name of the team with the highest average number of goals scored per game across all seasons" do
      best_team = @stat_tracker.best_offense

      expect(best_team).to eq("Columbus Crew SC")
    end
  end

  describe "#worst_offense" do
    it "can return the name of the team with the lowest average number of goals scored per game across all seasons" do
      worst_team = @stat_tracker.worst_offense

      expect(worst_team).to eq("Portland Thorns FC")
    end
  end

  describe "#highest_scoring_visitor" do
    it "can return the name with the highest average score per game across all seasons when they are visitor" do
      best_visitor = @stat_tracker.highest_scoring_visitor

      expect(best_visitor).to eq("Real Salt Lake")
    end
  end

  describe "#lowest_scoring_visitor" do
    it "can return the name of the team with the lowest average score per game across all seasons when they are a visitor" do
      worst_visitor = @stat_tracker.lowest_scoring_visitor

      expect(worst_visitor).to eq("Philadelphia Union")
    end
  end

  describe "#highest_scoring_home_team" do
    it "can return the name with the highest average score per game across all seasons when they are home" do
      best_team = @stat_tracker.highest_scoring_home_team

      expect(best_team).to eq("Philadelphia Union")
    end
  end

  describe "#lowest_scoring_home_team" do
    it "can return the name of the team with the lowest average score per game across all seasons when they are at home" do
      worst_team = @stat_tracker.lowest_scoring_home_team

      expect(worst_team).to eq("Portland Thorns FC")
    end
  end

  describe "#season statistics" do
    it "can display the winningest coach" do
      expect(@stat_tracker.winningest_coach("20162017")).to eq "Peter Laviolette"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Bruce Boudreau"
    end

    it "can display the worst coach" do
      expect(@stat_tracker.worst_coach("20162017")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Paul Maurice"))
    end

    it "can display the team with highest ratio of shots to goals for the season" do
      expect(@stat_tracker.most_accurate_team("20142015")).to eq "Columbus Crew SC"
      expect(@stat_tracker.most_accurate_team("20162017")).to eq "Minnesota United FC"
    end

    it "can display the team with the lowest ratio of shots to goals for the season" do
      expect(@stat_tracker.least_accurate_team("20142015")).to eq "Portland Thorns FC"
      expect(@stat_tracker.least_accurate_team("20162017")).to eq "Philadelphia Union"
    end

    it "can display the team with the most tackles for the season" do
      expect(@stat_tracker.most_tackles("20142015")).to eq "Portland Thorns FC"
      expect(@stat_tracker.most_tackles("20162017")).to eq "Minnesota United FC"
    end

    it "can display the team with the fewest tackles for the season" do
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "Philadelphia Union"
      expect(@stat_tracker.fewest_tackles("20162017")).to eq "Philadelphia Union"
    end
  end
end
# rubocop:enable Metrics/BlockLength
