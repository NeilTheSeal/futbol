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
      expect(@stat_generator.game_teams).to eq(@game_teams)
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

    xit "can list game teams by season" do
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
  end

  describe "#season statistics" do
    it "can display the winningest coach" do
      expect(@stat_generator.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_generator.winningest_coach("20142015")).to eq "Alain Vigneault"
    end
  end
end
# rubocop:enable Metrics/BlockLength
