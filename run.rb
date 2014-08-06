require_relative 'game'
require_relative 'location'

Game.new({
  [0,0] => Location.new("No crumbs", false),
  [0,1] => Location.new("No crumbs, maybe to the east?", false),
  [0,2] => Location.new("Mother fucking BREADCRUMBS!", true),

  [1,0] => Location.new("Bench, but no crumbs", false),
  [1,1] => Location.new("It's a long bench!", false),
  [1,2] => Location.new("CRUMBS", true),

  [2,0] => Location.new("What's this? A shop?", false, [:lettuce, :lettuce]),
  [2,1] => Location.new("Crumbs sprinkled outside the shop", true),
  [2,2] => Location.new("More crumbs, you lucky duck!", true),

}).run

# Location needs a way to say if it is a shop
#
