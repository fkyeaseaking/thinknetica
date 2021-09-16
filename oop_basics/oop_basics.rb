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
  attr_reader :first_station, :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
    @stations << first_station << last_station
    @way_stations = []
  end

  def add_way_station(station)
    @way_stations << station
    @stations.insert(@stations.size - 1, station)
  end

  def remove_way_station(station)
    @stations.delete(station) if @way_stations.include?(station)
    @way_stations.delete(station)
  end

  def display_stations
    @stations.each { |station| puts station.name }
  end
end

class Train
  attr_accessor :speed, :route
  attr_reader   :cars_count, :current_station, :next_station, :previous_station, :type, :number

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
    @current_station = route.first_station
    @current_station.add_train(self)
  end

  def next_station
    return @current_station if @current_station == @route.stations.last
    index = @route.stations.find_index(@current_station)
    @next_station = @route.stations[index+1]
  end

  def previous_station
    return @current_station if @current_station == @route.stations.first
    index = @route.stations.find_index(@current_station)
    @previous_station = @route.stations[index-1]
  end

  def move_up
    @current_station.send_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_down
    @current_station.send_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end
end
