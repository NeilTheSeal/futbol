require "spec_helper"

RSpec.describe GameStats do
  before(:each) do
    @game_stats = GameStats.new
  end

  describe "#initialize" do
    it "exists" do
      expect(@game_stats).to be_a(GameStats)
    end
  end
end
