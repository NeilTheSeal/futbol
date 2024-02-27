require 'spec_helper'

RSpec.describe GameTeam do
  before(:each) do
    @game_team1 = GameTeam.create_game_teams('./data/game_teams.csv')[0]
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game_team1).to be_a(GameTeam)
    end
  end

  describe '::create_game_teams' do
    it 'creates GameTeam instances from a CSV file' do
      game_teams = GameTeam.create_game_teams('./data/game_teams.csv')

      expect(game_teams).to all be_a(GameTeam)
    end
  end
end