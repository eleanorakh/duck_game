class Map
  attr_reader :locations

  def initialize(locations)
    @locations = locations
  end

  def find(coordinates)
    @locations[coordinates]
  end

  def find!(coordinates)
    @locations.fetch(coordinates)
  end
end
