require_relative "map"
require_relative "duck"

class Game
  DEFAULT_LOCATION = [0,0]
  INVENTORY_WIDTH = 2
  INVENTORY_SIZE = 4
  #   0 1 2
  # 0 # # x
  # 1 # # x
  # 2

  def initialize(map_hash)
    @map = Map.new(map_hash)
    @current_location = DEFAULT_LOCATION
    @duck = Duck.new
  end

  def run
    @duck.set_name

    loop do
      break if @exit
      tick
    end
  end

  def tick
    menu
    puts nil
  end

  def menu
    move_regex = /mo?v?e? (.)/
    puts "What would you like to do?"
    print ":"
    input = gets.strip
    case input
    when 'exit'
      @exit = true
    when move_regex
      bearing = input.match(move_regex)[1]
      move(bearing)
    when "i"
      puts "Your health is currently #{@duck.health}."

      inventory_lines = []
      inventory = @duck.inventory.dup
      inventory_height.times do
        values_for_lines = inventory.shift(INVENTORY_WIDTH)
        value_1 = values_for_lines[0]
        value_2 = values_for_lines[1]
        inventory_lines << "| #{value_1 ? value_1[0] : ' '} | #{value_2 ? value_2[0] : ' '} |"
      end

      puts '+-------+'
      puts inventory_lines.join("\n|---+---|\n")
      puts '+-------+'
    else
      puts "You're addled! That's not a vaild command."
    end

  end

  def move(bearing)
    @duck.reduce_health
    if @duck.health == 0
      puts "You didn't find enough breadcrumbs. Wildlife rescue healed you then returned you to the park, but you're back at the start!"
      puts "-" * 80
      @current_location = DEFAULT_LOCATION
      @duck.set_default_health
    else
      last_location = @current_location.dup
      @current_location = update_coordinates(@current_location, bearing)
      print @current_location
      if @map.find(@current_location).nil?
        @current_location = last_location
        puts "You've strayed too far! A helpful human put you back in the park."
      else
        puts "You went #{bearing.upcase}, good work #{@duck.name}."
      end
    end

    puts "You are at #{@current_location}."
    puts current_location_object.description

    if current_location_object.breadcrumbs
      @duck.add_to_inventory(:breadcrumb)
    end

    if current_location_object.shop?
      shop
    end

    if current_location_object.treetrunks
      treetrunks
    end
  end

  def treetrunks
    if @duck.inventory.include?(:apple)
      @duck.remove_from_inventory(:apple)
      @duck.add_to_inventory(:pie)
      puts "make pie"
    else
      puts "say sorry you need an apple to trade for pie"
    end
  end


  def shop
    if current_location_object.shop_inventory.empty?
      puts "There's nothing for sale at the moment"
    else

      counts = current_location_object.shop_inventory.inject({}) do |counts, item|
        counts[item] = (counts[item] || 0) + 1
        counts
      end

      puts "We have:"
      counts.each do |item, count|
        puts "  - #{item} (#{count})"
      end

      puts "Would you like to buy some? 1 breadcrumb per item. (Type 'buy [item]')"
      print ":"
      input = gets.strip

      if match_data = input.match(/buy (.+)/)
        input = match_data.captures.first
      end

      case
      when current_location_object.shop_inventory.uniq.map(&:to_s).include?(input)
        if @duck.inventory.include?(:breadcrumb)

          @duck.remove_from_inventory(:breadcrumb)

          index_to_delete = current_location_object.shop_inventory.index(input.to_sym)
          current_location_object.shop_inventory.delete_at(index_to_delete)

          @duck.add_to_inventory(input.to_sym)
          puts "You have purchased #{input}"
        else
          puts "You have no breadcrumbs! Better keep searching."
        end
      when input == "n"
        puts "You don't want anything"
      else
        puts "That's not a vaild command! You're addled!"
        shop
      end
    end
  end

  def update_coordinates(current, bearing)
    new_coordinates = current.dup
    case bearing
    when "S", "s"
      new_coordinates[0] = current[0] + 1
    when "N", "n"
      new_coordinates[0] = current[0] - 1
    when "E", "e"
      new_coordinates[1] = current[1] + 1
    when "W", "w"
      new_coordinates[1] = current[1] - 1
    else
      raise "I don't know what bearing #{bearing} is."
    end
    new_coordinates
  end

  def inventory_height
    INVENTORY_SIZE/INVENTORY_WIDTH
  end

  def current_location_object
    @map.find!(@current_location)
  end
end

# show how many lettuce available
# remove lettuce from Location when purchased
