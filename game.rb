class Game
  DEFAULT_HEALTH = 5
  DEFAULT_LOCATION = [0,0]
  INVENTORY_WIDTH = 2
  #   0 1 2
  # 0 # # x
  # 1 # # x
  # 2

  def initialize(map)
    @map = map
    @current_location = DEFAULT_LOCATION
    @health = DEFAULT_HEALTH
    @inventory = []
    @inventory_size = 4
  end

  def run
    puts "You're a fancy looking duck, what is your name?"
    @name = gets.strip

    loop do
      menu
      puts
    end
  end

  def menu
    move_regex = /mo?v?e? (.)/
    puts "What would you like to do?"
    print ":"
    input = gets.strip
    case input
    when move_regex
      bearing = input.match(move_regex)[1]
      move(bearing)
    when "i"
      puts "Your health is currently #{@health}."

      inventory_lines = []
      inventory = @inventory.dup
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
    @health = @health - 1
    if @health == 0
      puts "You didn't find enough breadcrumbs. Wildlife rescue healed you then returned you to the park, but you're back at the start!"
      puts "-" * 80
      @current_location = DEFAULT_LOCATION
      @health = DEFAULT_HEALTH
    else
      last_location = @current_location.dup
      @current_location = update_coordinates(@current_location, bearing)
      if @map[@current_location].nil?
        @current_location = last_location
        puts "You've strayed too far! A helpful human put you back in the park."
      else
        puts "You went #{bearing.upcase}, good work #{@name}."
      end
    end

    puts "You are at #{@current_location}."
    puts @map.fetch(@current_location).description

    if @map.fetch(@current_location).breadcrumbs
      @inventory << :breadcrumb
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
    @inventory_size/INVENTORY_WIDTH
  end
end
