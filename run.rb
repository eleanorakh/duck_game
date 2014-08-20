require_relative 'game'
require_relative 'location'

Game.new({
  [0,0] => Location.new(:description => "Crumbs", :breadcrumbs => true),
  [0,1] => Location.new(:description => "No crumbs, maybe to the east?",),
  [0,2] => Location.new(:description => "Mother fucking BREADCRUMBS!", :breadcrumbs => true),

  [1,0] => Location.new(:description => "What's this? A shop?", :shop_inventory => [:lettuce, :lettuce, :apple], :shop => true),
  [1,1] => Location.new(:description => "Bench, but no crumbs, but treetrunks is here!", :treetrunks => true),
  [1,2] => Location.new(:description => "CRUMBS", :breadcrumbs => true),

  [2,0] => Location.new(:description => "What's this? A shop?", :shop_inventory => [:lettuce, :lettuce, :apple], :shop => true),
  [2,1] => Location.new(:description => "Crumbs sprinkled outside the shop", :breadcrumbs => true),
  [2,2] => Location.new(:description => "More crumbs, you lucky duck!", :breadcrumbs => true),

}).run

# Location needs a way to say if it is a shop
#
