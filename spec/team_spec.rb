require 'spec_helper'

RSpec.describe Team do
  before(:all) do
    @teams = Team.create_teams('./data/teams.csv')
  end

  before(:each) do
    @team1 = @teams[0]
  end

  describe '#initialize' do
    it 'exists' do
      expect(@team1).to be_a(Team)
    end
  end

  describe '::create_teams' do
    it 'creates Team instances from a CSV file' do
      expect(@teams).to all be_a(Team)
    end
  end
end