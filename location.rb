class Location
  attr_reader :description, :breadcrumbs

  def initialize(description, breadcrumbs)
    @description = description
    @breadcrumbs = breadcrumbs
  end
end
