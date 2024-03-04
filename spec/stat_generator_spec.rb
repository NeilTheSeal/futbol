require "spec_helper"

# rubocop:disable Metrics/BlockLength
RSpec.describe StatGenerator do
  before(:all) do
    @games = Game.create_games("./fixture_data/games_fixture.csv")
    @game_teams = GameTeam.create_game_teams("./fixture_data/game_teams_fixture.csv")
    @teams = Team.create_teams("./fixture_data/teams_fixture.csv")
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

  describe "#checks highest total score and lowest total score" do
    it "Calculates the highest total score for all games" do
      expect(@stat_generator.highest_total_score).to eq(7)

      allow(@games[2]).to receive(:total_score).and_return(25)

      expect(@stat_generator.highest_total_score).to eq(25)
    end

    it "Calculates the lowest total score of all games" do
      expect(@stat_generator.lowest_total_score).to eq(3)

      allow(@games[1]).to receive(:total_score).and_return(2)

      expect(@stat_generator.lowest_total_score).to eq(2)
    end
  end

  describe "#total games" do
    it "displays the total number of games" do
      expect(@stat_generator.count_of_games).to eq(14)

      game_2 = double
      @games << game_2

      expect(@stat_generator.count_of_games).to eq(15)

      @games.pop
    end
  end

  describe "#wins at home " do
    it "displays total home wins" do
      expect(@stat_generator.total_home_wins).to eq(8)

      allow(@games[8]).to receive(:home_goals).and_return(5)

      expect(@stat_generator.total_home_wins).to eq(9)
    end

    it "displays the percent won at home " do
      expect(@stat_generator.percentage_home_wins).to eq(0.57)

      allow(@games[8]).to receive(:home_goals).and_return(5)

      expect(@stat_generator.percentage_home_wins).to eq(0.64)
    end
  end

  describe "#wins as visitor " do
    it "displays total wins as visitor" do
      expect(@stat_generator.total_visitor_wins).to eq(5)

      allow(@games[0]).to receive(:visitor_goals).and_return(5)

      expect(@stat_generator.total_visitor_wins).to eq(6)
    end

    it "displays the percent won visitor " do
      expect(@stat_generator.percentage_visitor_wins).to eq(0.36)

      allow(@games[0]).to receive(:visitor_goals).and_return(5)

      expect(@stat_generator.percentage_visitor_wins).to eq(0.43)
    end
  end

  describe "#ties " do
    it "displays the total ties" do
      expect(@stat_generator.total_ties).to eq(1)

      allow(@games[0]).to receive(:visitor_goals).and_return(3)
      allow(@games[0]).to receive(:home_goals).and_return(3)

      expect(@stat_generator.total_ties).to eq(2)
    end

    it "displays the percent of how many games they had a tie" do
      expect(@stat_generator.percentage_ties).to eq(0.07)

      allow(@games[0]).to receive(:visitor_goals).and_return(3)
      allow(@games[0]).to receive(:home_goals).and_return(3)

      expect(@stat_generator.percentage_ties).to eq(0.14)
    end
  end

  describe "#count of games by season" do
    it "count all games per season" do
      expected = {
        "20162017" => 6,
        "20142015" => 8
      }
      expect(@stat_generator.count_of_games_by_season).to eq(expected)

      allow(@games[0]).to receive(:season).and_return("20142015")

      new_expected = {
        "20162017" => 5,
        "20142015" => 9
      }

      expect(@stat_generator.count_of_games_by_season).to eq(new_expected)
    end
  end

  describe "#average goals per game " do
    it "calculates average goals per game " do
      expect(@stat_generator.average_goals_per_game).to eq(4.21)

      allow(@games[2]).to receive(:total_score).and_return(9)

      expect(@stat_generator.average_goals_per_game).to eq(4.57)
    end
  end

  describe "#average goals by season" do
    it "calculates the average goals each season" do
      expected = {
        "20162017" => 4.0,
        "20142015" => 4.38
      }
      expect(@stat_generator.average_goals_by_season).to eq(expected)

      allow(@games[2]).to receive(:total_score).and_return(10)
      allow(@games[13]).to receive(:total_score).and_return(15)

      new_expected = {
        "20162017" => 5.0,
        "20142015" => 5.63
      }
      expect(@stat_generator.average_goals_by_season).to eq(new_expected)
    end
  end

  describe "#helper methods" do
    it "can list seasons" do
      seasons = %w[20162017 20142015]
      expect(@stat_generator.seasons).to eq(seasons)

      allow(@games[13]).to receive(:season).and_return("20242025")

      new_seasons = %w[20162017 20142015 20242025]

      expect(@stat_generator.seasons).to eq(new_seasons)
    end

    it "can list game teams by season" do
      season_game_team_list = @stat_generator.game_team_by_season

      expect(season_game_team_list.keys.empty?).to eq(false)

      season_game_team_list.each_value do |game_team_array|
        expect(game_team_array.empty?).to eq(false)
        expect(game_team_array).to all be_a(GameTeam)
      end
    end

    it "can list every head coach" do
      coaches_list = @stat_generator.coaches

      expect(coaches_list.empty?).to be false

      expect(coaches_list).to all be_a String
    end

    it "can list head coaches by season" do
      coaches_list = @stat_generator.coaches_by_season

      coaches_list.each_value do |coach_array|
        expect(coach_array.empty?).to be false
        expect(coach_array).to all be_a String
      end
    end

    it "can create hashes with array values" do
      keys = %w[A B C]
      hash = @stat_generator.generate_array_hash(keys)

      expect(hash.keys).to all be_a(Symbol)
      expect(hash.values).to all be_a(Array)
    end

    it "can create hashes with zero values" do
      keys = %w[A B C]
      hash = @stat_generator.generate_integer_hash(keys)

      expect(hash.keys).to all be_a(Symbol)
      expect(hash.values).to all eq(0)
    end

    it "can use coach_evaluation method for winning" do
      expect(@stat_generator.coach_evaluation(
               "20162017", "winner"
             )).to eq "Peter Laviolette"

      expect(@stat_generator.coach_evaluation(
               "20142015", "winner"
             )).to eq "Bruce Boudreau"
    end

    it "can use coach_evaluation method for losing" do
      expect(@stat_generator.coach_evaluation(
               "20162017", "loser"
             )).to eq "Peter Laviolette"

      expect(@stat_generator.coach_evaluation(
               "20142015", "loser"
             )).to eq("Craig MacTavish").or(eq("Paul Maurice"))
    end

    it "can generate a hash of team stats by season" do
      hash = @stat_generator.stats_by_id_and_season

      expect(hash.keys).to all be_a(Symbol)

      hash.each_value do |id_hash|
        expect(id_hash.keys).to all be_a(Symbol)

        id_hash.each_value do |stats|
          expect(stats[:shots]).to be_a(Integer)
          expect(stats[:goals]).to be_a(Integer)
          expect(stats[:tackles]).to be_a(Integer)
        end
      end
    end

    it "can display total goals for all games " do
      expect(@stat_generator.total_goals).to eq(59.0)

      allow(@games[2]).to receive(:total_score).and_return(10)

      expect(@stat_generator.total_goals).to eq(65.0)
    end

    it "can display the total goals for each season" do
      expect(@stat_generator.total_goals_by_season("20162017")).to eq(24.0)
      expect(@stat_generator.total_goals_by_season("20142015")).to eq(35.0)
    end

    it "can display the average goals for a season" do
      expect(@stat_generator.average_goals_per_season("20162017")).to eq(4.0)
      expect(@stat_generator.average_goals_per_season("20142015")).to eq(4.375)
    end
  end

  describe "#season statistics" do
    it "can display the winningest coach" do
      expect(@stat_generator.winningest_coach("20162017")).to eq "Peter Laviolette"
      expect(@stat_generator.winningest_coach("20142015")).to eq "Bruce Boudreau"
    end

    it "can display the worst coach" do
      expect(@stat_generator.worst_coach("20162017")).to eq "Peter Laviolette"
      expect(@stat_generator.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Paul Maurice"))
    end

    it "can display the team with highest ratio of shots to goals for the season" do
      expect(@stat_generator.most_accurate_team("20142015")).to eq "Columbus Crew SC"
      expect(@stat_generator.most_accurate_team("20162017")).to eq "Minnesota United FC"
    end

    it "can display the team with the lowest ratio of shots to goals for the season" do
      expect(@stat_generator.least_accurate_team("20142015")).to eq "Portland Thorns FC"
      expect(@stat_generator.least_accurate_team("20162017")).to eq "Philadelphia Union"
    end

    it "can display the team with the most tackles for the season" do
      expect(@stat_generator.most_tackles("20142015")).to eq "Portland Thorns FC"
      expect(@stat_generator.most_tackles("20162017")).to eq "Minnesota United FC"
    end

    it "can display the team with the fewest tackles for the season" do
      expect(@stat_generator.fewest_tackles("20142015")).to eq "Philadelphia Union"
      expect(@stat_generator.fewest_tackles("20162017")).to eq "Philadelphia Union"
    end
  end

  describe "#count_of_teams" do
    it "can count the number of teams" do
      expect(@stat_generator.count_of_teams).to eq(5)

      teams_2 = double
      @teams << teams_2

      expect(@stat_generator.count_of_teams).to eq(6)

      @teams.pop
    end
  end

  describe "#total_games_played_by_team" do
    it "can find the total games played by a team for all seasons" do
      team1_games = @stat_generator.total_games_played_by_team("19")

      expect(team1_games).to eq(7)

      team2_games = @stat_generator.total_games_played_by_team("53")

      expect(team2_games).to eq(4)
    end

    it "can find the total games played by a team when visitor for all seasons" do
      team1_games = @stat_generator.total_games_played_by_team("19", "visitor")

      expect(team1_games).to eq(3)

      team2_games = @stat_generator.total_games_played_by_team("24", "visitor")

      expect(team2_games).to eq(2)
    end

    it "can find the total games played by a team when home for all seasons" do
      team1_games = @stat_generator.total_games_played_by_team("19", "home")

      expect(team1_games).to eq(4)

      team2_games = @stat_generator.total_games_played_by_team("53", "home")

      expect(team2_games).to eq(1)
    end
  end

  describe "#total_goals_by_team" do
    it "can find the total goals made by a team for all seasons" do
      team1_goals = @stat_generator.total_goals_by_team("19")

      expect(team1_goals).to eq(14)

      team2_goals = @stat_generator.total_goals_by_team("53")

      expect(team2_goals).to eq(11)
    end

    it "can find the total goals made by a team when visitor for all seasons" do
      team1_goals = @stat_generator.total_goals_by_team("19", "visitor")

      expect(team1_goals).to eq(3)

      team2_goals = @stat_generator.total_goals_by_team("53", "visitor")

      expect(team2_goals).to eq(9)
    end

    it "can find the total goals made by a team when home for all seasons" do
      team1_goals = @stat_generator.total_goals_by_team("19", "home")

      expect(team1_goals).to eq(11)

      team2_goals = @stat_generator.total_goals_by_team("53", "home")

      expect(team2_goals).to eq(2)
    end
  end

  describe "#average_goals_per_game_by_team" do
    it "can find the average goals made per game by a team for all seasons" do
      team1_average = @stat_generator.average_goals_per_game_by_team("19")

      expect(team1_average).to eq(2.0)

      team2_average = @stat_generator.average_goals_per_game_by_team("53")

      expect(team2_average).to eq(2.75)
    end

    it "can find the average goals made per game by a team when visitor for all seasons" do
      team1_average = @stat_generator.average_goals_per_game_by_team("19",
                                                                     "visitor")

      expect(team1_average).to eq(1.00)

      team2_average = @stat_generator.average_goals_per_game_by_team("53",
                                                                     "visitor")

      expect(team2_average).to eq(3.0)
    end

    it "can find the average goals made per game by a team when home for all seasons" do
      team1_average = @stat_generator.average_goals_per_game_by_team("19",
                                                                     "home")

      expect(team1_average).to eq(2.75)

      team2_average = @stat_generator.average_goals_per_game_by_team("53",
                                                                     "home")

      expect(team2_average).to eq(2.0)
    end
  end

  describe "#best_offense" do
    it "can return the name of the team with the highest average number of goals scored per game across all seasons" do
      expect(@stat_generator.best_offense).to eq("Columbus Crew SC")

      allow(@game_teams[1]).to receive(:goals).and_return("999999")

      expect(@stat_generator.best_offense).to eq("Philadelphia Union")
    end
  end

  describe "#worst_offense" do
    it "can return the name of the team with the lowest average number of goals scored per game across all seasons" do
      expect(@stat_generator.worst_offense).to eq("Portland Thorns FC")

      allow(@game_teams[12]).to receive(:goals).and_return("999999")

      expect(@stat_generator.worst_offense).to eq("Philadelphia Union")
    end
  end

  describe "#highest_scoring_visitor" do
    it "can return the name with the highest average score per game across all seasons when they are visitor" do
      expect(@stat_generator.highest_scoring_visitor).to eq("Real Salt Lake")

      allow(@game_teams[12]).to receive(:goals).and_return("999999")

      expect(@stat_generator.highest_scoring_visitor).to eq("Portland Thorns FC")
    end
  end

  describe "#lowest_scoring_visitor" do
    it "can return the name of the team with the lowest average score per game across all seasons when they are a visitor" do
      expect(@stat_generator.lowest_scoring_visitor).to eq("Philadelphia Union")

      allow(@game_teams[4]).to receive(:goals).and_return("999999")

      expect(@stat_generator.lowest_scoring_visitor).to eq("Minnesota United FC")
    end
  end

  describe "#highest_scoring_home_team" do
    it "can return the name with the highest average score per game across all seasons when they are home" do
      expect(@stat_generator.highest_scoring_home_team).to eq("Philadelphia Union")

      allow(@game_teams[5]).to receive(:goals).and_return("999999")

      expect(@stat_generator.highest_scoring_home_team).to eq("Minnesota United FC")
    end
  end

  describe "#lowest_scoring_home_team" do
    it "can return the name of the team with the lowest average score per game across all seasons when they are at home" do
      expect(@stat_generator.lowest_scoring_home_team).to eq("Portland Thorns FC")

      allow(@game_teams[17]).to receive(:goals).and_return("999999")

      expect(@stat_generator.lowest_scoring_home_team).to eq("Real Salt Lake")
    end
  end
end
# rubocop:enable Metrics/BlockLength
