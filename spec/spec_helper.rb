require "simplecov"
SimpleCov.start
require "./lib/stat_generator"
require "./lib/game_team"
require "./lib/game"
require "./lib/stat_tracker"
require "./lib/team"

RSpec.configure do |config|
  config.formatter = :documentation
end
