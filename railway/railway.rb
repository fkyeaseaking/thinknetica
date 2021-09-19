class RailWay
  attr_reader :stations, :routes, :train_cars, :trains

  def initialize
    @stations = []
    @routes = []
    @train_cars = []
    @trains = []
  end

  def menu
    loop do
      puts "Enter 'create' to create station, route, car or train"
      puts "Enter 'manage' to manage existing object"
      puts "Enter 'info' to get info about object"
      exit_tip

      input = gets.chomp.downcase

      case input
      when "create"
        create_menu
      when "manage"
        manage_menu
      when "info"
        info_menu
      when "exit"
        break
      end

      dividing_line
    end
  end

  private

  def create_menu
    type_of_object_tip
    exit_tip

    input = gets.chomp.downcase

    case input
    when "station"
      create_station_menu
    when "route"
      create_route_menu
    when "car"
      create_car_menu
    when "train"
      create_train_menu
    when "exit"
      self.menu
    end
  end

  def manage_menu
    type_of_object_tip
    exit_tip

    input = gets.chomp.downcase

    case input
    when "station"
      manage_station_menu
    when "route"
      manage_route_menu
    when "car"
      manage_car_menu
    when "train"
      manage_train_menu
    when "exit"
      self.menu
    end
  end

  def info_menu
    type_of_object_tip
    exit_tip

    input = gets.chomp.downcase

    case input
    when "station"
      info_station_menu
    when "route"
      info_route_menu
    when "car"
      info_car_menu
    when "train"
      info_train_menu
    when "exit"
      self.menu
    end
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

  def create_car_menu
    puts "Enter train car type ('cargo', 'passenger'):"
    exit_tip

    type = gets.chomp.downcase
    exit_check(type)

    if type == "cargo"
      car = CargoCar.new
      @cars << car
      car_created_tip
    elsif type == "passenger"
      car = PassengerCar.new
      @cars << car
      car_created_tip
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

    number = gets.chomp.to_i
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
      station.display_trains

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
      route.display_stations

      puts "Enter station name:"
      station_name = gets.chomp
      route.remove_station(find_station(station_name))

      puts "Station #{station_name} removed"
      dividing_line
    end
  end

  def manage_car_menu
    puts "Select [number] train car to delete:"
    display_cars
    exit_tip

    index = get_index
    @train_cars.delete(@train_cars[index])
    
    puts "Train car deleted"
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

    puts "Select action('set route', 'add car', 'remove car', 'move up', 'move down'):"
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
    when "add car"
      puts "Train cars:"
      display_cars
      exit_tip

      index = get_index
      train.add_car(@train_cars[index])

      puts "Car has been added"
      dividing_line
    when "remove car"
      puts "#{train.number} Train cars:"
      train.cars.each_with_index { |car, index| puts "[#{index}] #{car}" }
      exit_tip

      index = get_index
      train.remove_car(@train_cars[index])

      puts "Car has been removed"
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

  def info_car_menu
    puts "Select car [number] (enter 'all' for all routes list):"
    display_cars
    exit_tip

    index = gets.chomp
    puts @train_cars if index.downcase == "all" 
    exit_check(index)
    index = index.to_i
    
    puts @train_cars[index]
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

  def display_cars
    @train_cars.each_with_index { |car, index| puts "[#{index}] #{car}" }
  end

  def get_index
    index = gets.chomp
    exit_check(index)
    index = index.to_i
  end

  def type_of_object_tip
    puts "Enter type of object ('station', 'route', 'car', 'train')"
  end

  def car_created_tip
    puts "Train car has been created"
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
