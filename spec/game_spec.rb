require 'spec_helper'

RSpec.describe Game do
  before(:each) do
    @game1 = Game.create_games('./data/games.csv')[0]
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game1).to be_a(Game)
    end
  end

  describe '::create_games' do
    it 'creates Game instances from a CSV file' do
      games = Game.create_games('./data/games.csv')

      expect(games).to all be_a(Game)
    end
  end
end