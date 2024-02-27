require 'spec_helper'

RSpec.describe GameTeam do
  before(:each) do
    @game_team = GameTeam.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game_team).to be_a(GameTeam)
    end
  end
end