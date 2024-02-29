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
    it "exists" do
      expect(@stat_generator).to be_a(StatGenerator)
    end

    it "has attributes" do
      expect(@stat_generator.games).to eq(@games)
      expect(@stat_generator.teams).to eq(@teams)
    end
  end

  describe '#checks highest total score and lowest total score' do
    it 'Calculates the highest total score for all games' do
      expect(@stat_generator.highest_total_score).to eq(11)
      # @game2 = Game.new() try to prove that 
    end

    it 'Calculates the lowest total score of all games' do 
      expect(@stat_generator.lowest_total_score).to eq(0)

    end
    
  end

  describe '#percent wins at home ' do
    it 'Sees the percent won at home ' do
      
      expect(@stat_generator.count_of_games).to eq(7441)

      expect(@stat_generator.total_home_wins).to eq(3237)

      expect(@stat_generator.percentage_home_wins).to eq(0.44)
    end
  end
  
  describe '#percent wins away ' do
  it 'Sees the percent won away ' do
    
    expect(@stat_generator.count_of_games).to eq(7441)
    
    expect(@stat_generator.total_away_wins).to eq(2687)
    
    expect(@stat_generator.percentage_away_wins).to eq(0.36)
    end
  end
  
  describe '#percent ties ' do
    it 'Sees the percent of how many games they had a tie' do
      
      expect(@stat_generator.count_of_games).to eq(7441)
      
      expect(@stat_generator.total_ties).to eq(1517)
      
      expect(@stat_generator.percentage_ties).to eq(0.2)
    end
  end

  describe "#helper methods" do
    it "can list seasons" do
      seasons = %w[20122013 20162017 20142015 20152016 20132014 20172018]
      expect(@stat_generator.seasons).to eq(seasons)
    end

    it "can list game ids by season" do
      season_id_list = @stat_generator.id_by_season
      expect(season_id_list.keys.empty?).to eq(false)
      season_id_list.each_value do |id_array|
        expect(id_array.empty?).to eq(false)
      end
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
               "20132014", "winner"
             )).to eq "Claude Julien"
      expect(@stat_generator.coach_evaluation(
               "20142015", "winner"
             )).to eq "Alain Vigneault"
    end

    it "can use coach_evaluation method for losing" do
      expect(@stat_generator.coach_evaluation(
               "20132014", "loser"
             )).to eq "Peter Laviolette"
      expect(@stat_generator.coach_evaluation(
               "20142015", "loser"
             )).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end
  end

  describe "#season statistics" do
    it "can display the winningest coach" do
      expect(@stat_generator.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_generator.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    it "can display the worst coach" do
      expect(@stat_generator.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_generator.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end
  end

  describe "#count_of_teams" do
    it "can count the number of teams" do
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
    it "can find the total games played by a team all seasons" do
      team1_games = @stat_generator.total_games_played_by_team("1")

      expect(team1_games).to eq(463)

      team2_games = @stat_generator.total_games_played_by_team("2")

      expect(team2_games).to eq(482)
    end
  end

  describe "#total_goals_by_team" do
    it "can find the total goals made by a team all seasons" do
      team1_goals = @stat_generator.total_goals_by_team("1")

      expect(team1_goals).to eq(896)

      team2_goals = @stat_generator.total_goals_by_team("2")

      expect(team2_goals).to eq(1053)
    end
  end

  describe "#average_goals_per_game_by_team" do
    it "can find the average goals made per game by a team all seasons" do
      team1_average = @stat_generator.average_goals_per_game_by_team("1")

      expect(team1_average).to eq(1.94)

      team2_average = @stat_generator.average_goals_per_game_by_team("2")

      expect(team2_average).to eq(2.18)
    end
  end

  describe "#best_offense" do
    it "can return the name of the team with the highest average number of goals scored per game across all seasons" do
      best_team = @stat_generator.best_offense

      expect(best_team).to eq("Reign FC")
    end
  end

  describe "#worst_offense" do
    it "can return the name of the team with the lowest average number of goals scored per game across all seasons" do
      worst_team = @stat_generator.worst_offense

      expect(worst_team).to eq("Utah Royals FC")
    end
  end
end
# rubocop:enable Metrics/BlockLength
