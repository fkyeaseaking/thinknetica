class Train
  attr_accessor :speed, :route, :cars
  attr_reader   :cars_count, :type, :number

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
  end

  def stop
    self.speed = 0
  end

  def add_carriage(carriage)
    if speed.zero? && carriage.type == self.type
      @carriages << carriage
    elsif speed.zero? && carriage.type != self.type
      puts "Wrong car type"
    elsif @carriages.include?(carriage)
      puts "Car already added to this train"
    else
      puts "Can't add carriage on the run"
    end
  end

  def remove_carriage(carriage)
    if speed.zero?
      @carriages.delete(carriage)
    else
      puts "Can't remove carriage on the run"
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
