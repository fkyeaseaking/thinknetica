require_relative "company_mixin.rb"
require_relative "instance_counter.rb"
require_relative "validation_check_mixin.rb"

class Train
  include CompanyMixin
  include InstanceCounter
  include ValidationCheckMixin

  attr_accessor :speed, :route, :cars
  attr_reader   :cars_count, :type, :number

  init_instances

  ERRORS = {
    empty_number: "Number can not be empty",
    wrong_number_format: "Wrong number format",
    too_short: "At least 5 characters"
  }

  NUMBER_FORMAT = /^\w{3}(-)?\w{2}$/i

  @@trains = []

  def initialize(number)
    @number = number
    validate!
    @speed = 0
    @carriages = []
    register_instance
    @@trains << self
  end

  def self.find(number)
    @@trains.each { |train| return train if train.number == number }
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

  def validate!
    raise ERRORS[:empty_number] if number.empty?
    raise ERRORS[:too_short] if number.length < 5
    raise ERRORS[:wrong_number_format] if number !~ NUMBER_FORMAT
    true
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1]
  end
end
