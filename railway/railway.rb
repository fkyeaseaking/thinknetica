class RailWay
  attr_reader :stations, :routes, :carriages, :trains

  def initialize
    @stations = []
    @routes = []
    @carriages = []
    @trains = []
  end

  MENU = [
    { keyword: "create", description: "create station, route, car or train" },
    { keyword: "manage", description: "manage existing object" },
    { keyword: "info", description: "get info about object" },]

  def menu
    loop do
      MENU.each { |item| puts "Enter '#{item[:keyword]}' to #{item[:description]}" }
      exit_tip

      input = gets.chomp.downcase
      break if input == "exit"

      sub_menu(input)

      dividing_line
    end
  end

  private

  def sub_menu(type)
    type_of_object_tip
    exit_tip

    input = gets.chomp.downcase
    exit_check(input)
    result_menu = "#{type}_" + input + "_menu"
    send(result_menu)
  end

  def create_station_menu
    puts "Enter station name"
    exit_tip

    input = gets.chomp
    exit_check(input)

    station = Station.new(input)
    @stations << station
    puts "Station #{station.name} created"
    dividing_line
  end

  def create_route_menu
    exit_tip

    puts "Existing stations:"
    display_stations

    puts "Enter first station name"
    first_station = gets.chomp
    exit_check(first_station)

    puts "Enter last station name"
    last_station = gets.chomp
    exit_check(last_station)

    route = Route.new(find_station(first_station), find_station(last_station))
    @routes << route
    puts "Route #{first_station}-#{last_station} created"
    dividing_line
  end

  def create_carriage_menu
    puts "Enter train carriage type ('cargo', 'passenger'):"
    exit_tip

    type = gets.chomp.downcase
    exit_check(type)

    if type == "cargo"
      carriage = CargoCarriage.new
      @carriages << carriage
      carriage_created_tip
    elsif type == "passenger"
      carriage = PassengerCarriage.new
      @carriages << carriage
      carriage_created_tip
    else
      wrong_type_tip
      dividing_line
    end
  end

  def create_train_menu
    puts "Enter train type ('cargo', 'passenger'):"
    exit_tip

    type = gets.chomp.downcase
    exit_check(type)

    puts "Enter train number:"
    exit_tip

    number = gets.chomp
    exit_check(number)

    if type == "cargo"
      train = CargoTrain.new(number)
      @trains << train
      train_created_tip
    elsif type == "passenger"
      train = PassengerTrain.new(number)
      @trains << train
      train_created_tip
    else
      wrong_type_tip
      dividing_line
    end

  rescue RuntimeError => e
    puts "ERROR: #{e.message}"
    dividing_line
    retry
  end

  def manage_station_menu
    puts "Stations:"
    display_stations
    puts "Enter name of station"
    exit_tip

    station_name = gets.chomp
    exit_check(station_name)

    station = find_station(station_name)

    puts "Select action ('delete', 'add train', 'send train'):"
    exit_tip

    input = gets.chomp.downcase
    exit_check(input)

    case input
    when "delete"
      @stations.delete(station)
    when "add train"
      puts "Trains:"
      display_trains
      puts "Enter train number"

      train_number = gets.chomp.to_i
      train = find_train(train_number)
      station.add_train(train)
    when "send train"
      puts "Trains on station:"
      station.trains { |train| puts train.number }

      train_number = gets.chomp.to_i
      train = find_train(train_number)
      station.send_train(train)
    end
  end

  def manage_route_menu
    puts "Routes:"
    display_routes
    puts "Select [number] of route: "
    exit_tip

    index = get_index
    route = @routes[index]

    puts "Select action('add station', 'remove station'):"
    exit_tip

    input = gets.chomp.downcase
    exit_check(input)

    case input
    when "add station"
      puts "Stations:"
      display_stations

      puts "Enter station name:"
      station_name = gets.chomp
      route.add_station(find_station(station_name))

      puts "Station #{station_name} added"
      dividing_line
    when "remove station"
      puts "Route's stations"
      route.stations.each { |station| puts station.name }

      puts "Enter station name:"
      station_name = gets.chomp
      route.remove_station(find_station(station_name))

      puts "Station #{station_name} removed"
      dividing_line
    end
  end

  def manage_carriage_menu
    puts "Select [number] train carriage to delete:"
    display_cars
    exit_tip

    index = get_index
    @carriages.delete(@carriages[index])
    
    puts "Train carriage deleted"
    dividing_line
  end

  def manage_train_menu
    puts "Trains:"
    display_trains
    exit_tip

    puts "Enter number of train:"
    train_number = gets.chomp
    exit_check(train_number)
    train_number = train_number.to_i
    train = find_train(train_number)

    puts "Select action('set route', 'add carriage', 'remove carriage', 'move up', 'move down'):"
    exit_tip

    input = gets.chomp.downcase
    exit_check(input)

    case input
    when "set route"
      puts "Routes:"
      display_routes
      puts "Select [number] of route: "
      exit_tip

      index = get_index

      train.set_route(@routes[index])
      "Route has been set"
      dividing_line
    when "add carriage"
      puts "Train cariages:"
      display_carriages
      exit_tip

      index = get_index
      train.add_carriage(@carriages[index])

      puts "Carriage has been added"
      dividing_line
    when "remove carriage"
      puts "#{train.number} Train carriages:"
      train.carriages.each_with_index { |car, index| puts "[#{index}] #{car}" }
      exit_tip

      index = get_index
      train.remove_carriage(@carriages[index])

      puts "Carriage has been removed"
      dividing_line
    when "move up"
      train.move_up
      puts "Train has been moved"
      dividing_line
    when "move down"
      train.move_down
      puts "Train has been moved"
      dividing_line
    end
  end

  def info_station_menu
    puts "Select station or enter 'all' for all station list:"
    display_stations
    exit_tip

    station_name = gets.chomp
    exit_check(station_name)
    puts @stations if station_name.downcase == "all"

    puts find_station(station_name)
    dividing_line
  end

  def info_route_menu
    puts "Select route [number] or enter 'all' for all routes list:"
    display_routes
    exit_tip

    index = gets.chomp
    puts @routes if index.downcase == "all" 
    exit_check(index)
    index = index.to_i
    
    puts @routes[index]
    dividing_line
  end

  def info_carriage_menu
    puts "Select carriage [number] (enter 'all' for all routes list):"
    display_carriages
    exit_tip

    index = gets.chomp
    puts @carriages if index.downcase == "all" 
    exit_check(index)
    index = index.to_i
    
    puts @carriages[index]
    dividing_line
  end

  def info_train_menu
    puts "Select train or enter 'all' for all train list:"
    display_trains
    exit_tip

    train_number = gets.chomp
    exit_check(train_number)
    puts @trains if train_name.downcase == "all"

    puts find_station(train_name)
    dividing_line
  end

  def exit_tip
    puts "Enter 'exit' to exit"
  end

  def exit_check(input)
    self.menu if input.downcase == "exit"
  end

  def find_station(station)
    @stations.each { |object| return object if object.name == station }
  end

  def display_stations
    @stations.each { |station| puts station.name }
  end

  def find_train(train)
    @train.each { |object| return object if object.number == train }
  end

  def display_trains
    @trains.each { |train| puts train.number }
  end

  def display_routes
    @routes.each_with_index { |route, index| puts "[#{index}] #{route.stations.first.name} - #{route.stations.last.name}" }
  end

  def display_carriagess
    @carriages.each_with_index { |car, index| puts "[#{index}] #{car}" }
  end

  def get_index
    index = gets.chomp
    exit_check(index)
    index = index.to_i
  end

  def type_of_object_tip
    puts "Enter type of object ('station', 'route', 'carriage', 'train')"
  end

  def carriage_created_tip
    puts "Train carriage has been created"
    dividing_line
  end

  def train_created_tip
    puts "Train has been created"
    dividing_line
  end

  def wrong_type_tip
    puts "Wrong type"
  end

  def dividing_line
    puts "====================="
  end
end
