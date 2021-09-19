class Train
  attr_accessor :speed, :route, :cars
  attr_reader   :cars_count, :type, :number

  def initialize(number)
    @number = number
    @speed = 0
    @cars = []
  end

  def stop
    self.speed = 0
  end

  def add_car(car)
    if speed.zero? && car.type == self.type
      @cars << car
    elsif speed.zero? && car.type != self.type
      puts "Wrong car type"
    elsif @cars.include?(car)
      puts "Car already added to this train"
    else
      puts "Can't add car on the run"
    end
  end

  def remove_car(car)
    if speed.zero?
      @cars.delete(car)
    else
      puts "Can't remove car on the run"
    end
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
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

  private

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end
end
