require "spec_helper"

# rubocop:disable Metrics/BlockLength
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
    xit "exists" do
      expect(@stat_generator).to be_a(StatGenerator)
    end

    xit "has attributes" do
      expect(@stat_generator.games).to eq(@games)
      expect(@stat_generator.teams).to eq(@teams)
    end
  end

  describe "#checks highest total score and lowest total score" do
    xit "Calculates the highest total score for all games" do
      expect(@stat_generator.highest_total_score).to eq(11)
      # @game2 = Game.new() try to prove that
    end

    xit "Calculates the lowest total score of all games" do
      expect(@stat_generator.lowest_total_score).to eq(0)
    end
  end

  describe "#percent wins at home " do
    xit "Sees the percent won at home " do
      expect(@stat_generator.count_of_games).to eq(7441)

      expect(@stat_generator.total_home_wins).to eq(3237)

      expect(@stat_generator.percentage_home_wins).to eq(0.44)
    end
  end

  describe "#percent wins away " do
    xit "Sees the percent won away " do
      expect(@stat_generator.count_of_games).to eq(7441)

      expect(@stat_generator.total_away_wins).to eq(2687)

      expect(@stat_generator.percentage_away_wins).to eq(0.36)
    end
  end

  describe "#percent ties " do
    xit "Sees the percent of how many games they had a tie" do
      expect(@stat_generator.count_of_games).to eq(7441)

      expect(@stat_generator.total_ties).to eq(1517)

      expect(@stat_generator.percentage_ties).to eq(0.2)
    end
  end

  describe "#helper methods" do
    xit "can list seasons" do
      seasons = %w[20122013 20162017 20142015 20152016 20132014 20172018]
      expect(@stat_generator.seasons).to eq(seasons)
    end

    xit "can list game ids by season" do
      season_id_list = @stat_generator.id_by_season
      expect(season_id_list.keys.empty?).to eq(false)
      season_id_list.each_value do |id_array|
        expect(id_array.empty?).to eq(false)
      end
    end

    xit "can list game teams by season" do
      season_game_team_list = @stat_generator.game_team_by_season
      expect(season_game_team_list.keys.empty?).to eq(false)
      season_game_team_list.each_value do |game_team_array|
        expect(game_team_array.empty?).to eq(false)
        expect(game_team_array).to all be_a(GameTeam)
      end
    end

    xit "can list every head coach" do
      coaches_list = @stat_generator.coaches
      expect(coaches_list.empty?).to be false
      expect(coaches_list).to all be_a String
    end

    xit "can list head coaches by season" do
      coaches_list = @stat_generator.coaches_by_season
      coaches_list.each_value do |coach_array|
        expect(coach_array.empty?).to be false
        expect(coach_array).to all be_a String
      end
    end

    xit "can create hashes with array values" do
      keys = %w[A B C]
      hash = @stat_generator.generate_array_hash(keys)
      expect(hash.keys).to all be_a(Symbol)
      expect(hash.values).to all be_a(Array)
    end

    xit "can create hashes with zero values" do
      keys = %w[A B C]
      hash = @stat_generator.generate_integer_hash(keys)
      expect(hash.keys).to all be_a(Symbol)
      expect(hash.values).to all eq(0)
    end

    xit "can use coach_evaluation method for winning" do
      expect(@stat_generator.coach_evaluation(
               "20162017", "winner"
             )).to eq "Mike Sullivan"
      expect(@stat_generator.coach_evaluation(
               "20142015", "winner"
             )).to eq "Alain Vigneault"
    end

    xit "can use coach_evaluation method for losing" do
      expect(@stat_generator.coach_evaluation(
               "20162017", "loser"
             )).to eq "Gerard Gallant"
      expect(@stat_generator.coach_evaluation(
               "20142015", "loser"
             )).to eq("Craig MacTavish").or(eq("Paul Maurice"))
    end

    xit "can generate a hash of team stats by season" do
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
  end

  describe "#season statistics" do
    xit "can display the winningest coach" do
      expect(@stat_generator.winningest_coach("20162017")).to eq "Mike Sullivan"
      expect(@stat_generator.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    xit "can display the worst coach" do
      expect(@stat_generator.worst_coach("20162017")).to eq "Gerard Gallant"
      expect(@stat_generator.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Paul Maurice"))
    end

    xit "can display the team with highest ratio of shots to goals for the season" do
      expect(@stat_generator.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@stat_generator.most_accurate_team("20142015")).to eq "Toronto FC"
    end

    xit "can display the team with the lowest ratio of shots to goals for the season" do
      expect(@stat_generator.least_accurate_team("20132014")).to eq "New York City FC"
      expect(@stat_generator.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end

    xit "can display the team with the most tackles for the season" do
      expect(@stat_generator.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@stat_generator.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    xit "can display the team with the fewest tackles for the season" do
      expect(@stat_generator.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@stat_generator.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end

  describe "#count_of_teams" do
    xit "can count the number of teams" do
      count = @stat_generator.count_of_teams

      expect(count).to be_a(Integer)

      details = Hash.new(0)
      @teams << Team.new(details)
      new_count = @stat_generator.count_of_teams

      expect(new_count).to eq(count + 1)

      @teams.pop
    end
  end

  describe "#total_games_played_by_team" do
    xit "can find the total games played by a team for all seasons" do
      team1_games = @stat_generator.total_games_played_by_team("19")

      expect(team1_games).to eq(507)

      team2_games = @stat_generator.total_games_played_by_team("53")

      expect(team2_games).to eq(328)
    end

    xit "can find the total games played by a team when away for all seasons" do
      team1_games = @stat_generator.total_games_played_by_team("19", "away")

      expect(team1_games).to eq(254)

      team2_games = @stat_generator.total_games_played_by_team("24", "away")

      expect(team2_games).to eq(258)
    end

    xit "can find the total games played by a team when home for all seasons" do
      team1_games = @stat_generator.total_games_played_by_team("19", "home")

      expect(team1_games).to eq(253)

      team2_games = @stat_generator.total_games_played_by_team("53", "home")

      expect(team2_games).to eq(164)
    end
  end

  describe "#total_goals_by_team" do
    xit "can find the total goals made by a team for all seasons" do
      team1_goals = @stat_generator.total_goals_by_team("19")

      expect(team1_goals).to eq(1068)

      team2_goals = @stat_generator.total_goals_by_team("53")

      expect(team2_goals).to eq(620)
    end

    xit "can find the total goals made by a team when away for all seasons" do
      team1_goals = @stat_generator.total_goals_by_team("19", "away")

      expect(team1_goals).to eq(519)

      team2_goals = @stat_generator.total_goals_by_team("53", "away")

      expect(team2_goals).to eq(303)
    end

    xit "can find the total goals made by a team when home for all seasons" do
      team1_goals = @stat_generator.total_goals_by_team("19", "home")

      expect(team1_goals).to eq(549)

      team2_goals = @stat_generator.total_goals_by_team("53", "home")

      expect(team2_goals).to eq(317)
    end
  end

  describe "#average_goals_per_game_by_team" do
    xit "can find the average goals made per game by a team for all seasons" do
      team1_average = @stat_generator.average_goals_per_game_by_team("19")

      expect(team1_average).to eq(2.11)

      team2_average = @stat_generator.average_goals_per_game_by_team("53")

      expect(team2_average).to eq(1.89)
    end

    xit "can find the average goals made per game by a team when away for all seasons" do
      team1_average = @stat_generator.average_goals_per_game_by_team("19",
                                                                     "away")

      expect(team1_average).to eq(2.04)

      team2_average = @stat_generator.average_goals_per_game_by_team("53",
                                                                     "away")

      expect(team2_average).to eq(1.85)
    end

    xit "can find the average goals made per game by a team when home for all seasons" do
      team1_average = @stat_generator.average_goals_per_game_by_team("19",
                                                                     "home")

      expect(team1_average).to eq(2.17)

      team2_average = @stat_generator.average_goals_per_game_by_team("53",
                                                                     "home")

      expect(team2_average).to eq(1.93)
    end
  end

  describe "#best_offense" do
    xit "can return the name of the team with the highest average number of goals scored per game across all seasons" do
      best_team = @stat_generator.best_offense

      expect(best_team).to eq("Reign FC")
    end
  end

  describe "#worst_offense" do
    xit "can return the name of the team with the lowest average number of goals scored per game across all seasons" do
      worst_team = @stat_generator.worst_offense

      expect(worst_team).to eq("Utah Royals FC")
    end
  end

  describe "#highest_scoring_visitor" do
    xit "can return the name with the highest average score per game across all seasons when they are away" do
      best_visitor = @stat_generator.highest_scoring_visitor

      expect(best_visitor).to eq("FC Dallas")
    end
  end

  describe "#lowest_scoring_visitor" do
    xit "can return the name of the team with the lowest average score per game across all seasons when they are a visitor" do
      worst_visitor = @stat_generator.lowest_scoring_visitor

      expect(worst_visitor).to eq("San Jose Earthquakes")
    end
  end

  describe "#highest_scoring_home_team" do
    xit "can return the name with the highest average score per game across all seasons when they are home" do
      best_team = @stat_generator.highest_scoring_home_team

      expect(best_team).to eq("Reign FC")
    end
  end

  describe "#lowest_scoring_home_team" do
    xit "can return the name of the team with the lowest average score per game across all seasons when they are at home" do
      worst_team = @stat_generator.lowest_scoring_home_team

      expect(worst_team).to eq("Utah Royals FC")
    end
  end
end
# rubocop:enable Metrics/BlockLength
