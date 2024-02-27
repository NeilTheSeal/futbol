require 'spec_helper'

RSpec.describe Team do
  before(:each) do
    @team = Team.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@team).to be_a(Team)
    end
  end
end