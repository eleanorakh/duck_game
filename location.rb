class Location
  attr_reader :description, :breadcrumbs, :shop

  def initialize(description, breadcrumbs, shop=false)
    @description = description
    @breadcrumbs = breadcrumbs
    @shop = shop
  end
end
