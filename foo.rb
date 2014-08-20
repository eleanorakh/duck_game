shop_inventory = [:lettuce, :lettuce, :apple]

x = shop_inventory.inject({}) do |counts, item|
  counts[item] = (counts[item] || 0) + 1
  counts
end
p x
