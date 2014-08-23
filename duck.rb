class Duck
  attr_accessor :health
  attr_reader :inventory

  DEFAULT_HEALTH = 50

  def initialize
    @health = DEFAULT_HEALTH
    @inventory = []
  end

  def set_default_health
    @health = DEFAULT_HEALTH
  end

  def reduce_health
    @health = @health - 1
  end

  def remove_from_inventory(item_type)
    index_to_delete = @inventory.index(item_type)
    @inventory.delete_at(index_to_delete)
  end

  def add_to_inventory(item_type)
    @inventory << item_type
  end
end
