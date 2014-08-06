INVENTORY_WIDTH = 2
@inventory_size = 6

def inventory_height
  @inventory_size/INVENTORY_WIDTH
end

@inventory = [:breadcrumb, :breadcrumb, :breadcrumb]

inventory_lines = []
inventory_food = @inventory.dup
inventory_height.times do
  values_for_lines = inventory_food.shift(INVENTORY_WIDTH)
  value_1 = values_for_lines[0]
  value_2 = values_for_lines[1]
  inventory_lines << "| #{value_1 ? value_1[0] : ' '} | #{value_2 ? value_2[0] : ' '} |"
end

puts '+-------+'
puts inventory_lines.join("\n|---+---|\n")
puts '+-------+'
