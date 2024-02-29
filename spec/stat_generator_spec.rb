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

  describe '#checks highest total score and lowest total score' do
    it 'Calculates the highest total score for all games' do
      expect(@stat_generator.highest_total_score).to eq(11)
      # @game2 = Game.new() try to prove that 
      expect(@stat_generator.highest_total_score).to_not eq(1)
    end

    it 'Calculates the lowest total score of all games' do 
      expect(@stat_generator.lowest_total_score).to eq(0)
      expect(@stat_generator.lowest_total_score).to_not eq(9)

    end
    
  end

  describe "#count_of_teams" do
    it "can count the number of teams" do
      count = @stat_generator.count_of_teams

      expect(count).to be_a(Integer)

      details = Hash.new(0)
      @teams << Team.new(details)
      new_count = @stat_generator.count_of_teams

      expect(new_count).to eq(count += 1)

      @teams.pop
    end
  end

  describe "#total_games_played_by_team" do
    it "can find the total games played by a team all seasons" do
      team1_games = @stat_generator.total_games_played_by_team(1)

      expect(team1_games).to eq(463)

      team2_games = @stat_generator.total_games_played_by_team(2)

      expect(team2_games).to eq(482)
    end
  end

  describe "#total_goals_by_team" do
    it "can find the total goals made by a team all seasons" do
      team1_goals = @stat_generator.total_goals_by_team(1)

      expect(team1_goals).to eq(896)

      team2_goals = @stat_generator.total_goals_by_team(2)

      expect(team2_goals).to eq(1053)
    end
  end

  describe "#average_goals_per_game_by_team" do
    it "can find the average goals made per game by a team all seasons" do
      team1_average = @stat_generator.average_goals_per_game_by_team(1)

      expect(team1_average).to eq(1.94)

      team2_average = @stat_generator.average_goals_per_game_by_team(2)

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
