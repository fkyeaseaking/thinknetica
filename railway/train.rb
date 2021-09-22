require_relative "company_mixin.rb"
require_relative "instance_counter.rb"

class Train
  include CompanyMixin
  include InstanceCounter

  attr_accessor :speed, :route, :cars
  attr_reader   :cars_count, :type, :number

  init_instances

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    register_instance
  end

  def self.find(number)
    ObjectSpace.each_object(self).to_a.each do |train|
      return train if train.number == number
    end
    nil
  end

  def stop
    self.speed = 0
  end

  def add_carriage(carriage)
    if speed.zero? && carriage.type == self.type
      carriages << carriage
    elsif speed.zero? && carriage.type != self.type
      puts "Wrong car type"
    elsif carriages.include?(carriage)
      puts "Car already added to this train"
    else
      puts "Can't add carriage on the run"
    end
  end

  def remove_carriage(carriage)
    if speed.zero?
      carriages.delete(carriage)
    else
      puts "Can't remove carriage on the run"
    end
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
  end

  def move_up
    route.stations[current_station_index].send_train(self)
    current_station_index += 1 if @current_station_index < @route.stations
    route.stations[current_station_index].add_train(self)
  end

  def move_down
    route.stations[current_station_index].send_train(self)
    current_station_index -= 1 if @current_station_index > 0
    route.stations[current_station_index].add_train(self)
  end

  private

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1]
  end
end
