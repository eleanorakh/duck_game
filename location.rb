class Location
  attr_reader :description, :breadcrumbs, :shop_inventory

  def initialize(description, breadcrumbs, shop_inventory, shop)
    @description = description
    @breadcrumbs = breadcrumbs
    @shop_inventory = shop_inventory
    @shop = shop
  end

  def shop?
    @shop
  end
end
