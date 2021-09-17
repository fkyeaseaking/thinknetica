class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def display_trains
    @trains.each { |train| train }
  end

  def display_trains_by_type(type)
    @trains.each { |train| train if train.type == type }
  end
end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(@stations.size - 1, station)
  end

  def remove_station(station)
    @way_stations.delete(station)
  end

  def display_stations
    @stations.each { |station| puts station.name }
  end
end

class Train
  attr_accessor :speed, :route
  attr_reader   :cars_count, :next_station, :previous_station, :type, :number

  def initialize(number, type, cars_count)
    @number = number
    @type = type
    @cars_count = cars_count
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def add_car
    if speed == 0
      @cars_count += 1
    else
      puts "Can't add car on the run"
    end
  end

  def remove_car
    if speed == 0
      @cars_count -= 1
    else
      puts "Can't remove car on the run"
    end
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index + 1]
  end

  def move_up
    @stations[current_station_index].send_train(self)
    @current_station_index += 1 if @current_station_index < @route.stations
    @stations[current_station_index].add_train(self)
  end

  def move_down
    @stations[current_station_index].send_train(self)
    @current_station_index -= 1 if @current_station_index > 0
    @stations[current_station_index].add_train(self)
  end
end
