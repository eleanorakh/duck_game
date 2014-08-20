class Location
  attr_reader :description, :breadcrumbs, :shop_inventory, :treetrunks

  def initialize(options = {})
    @description = options[:description] || 'Plain ole grass'
    @breadcrumbs = options[:breadcrumbs]
    @shop_inventory = options[:shop_inventory] || []
    @shop = options[:shop]
    @treetrunks = options[:treetrunks]
  end

  def shop?
    @shop
  end
end
