require_relative "company_mixin"
require_relative "instance_counter"
require_relative "accessors_mixin"
require_relative "validation_mixin"

class Train
  include CompanyMixin
  include InstanceCounter
  include Validation
  extend Accessors

  NUMBER_FORMAT = /^\w{3}(-)?\w{2}$/i.freeze

  init_instances
  attr_accessor_with_history :speed, :route, :cars, :cars_count, :type, :number, :carriages
  validate :number, :format, NUMBER_FORMAT
  validate :number, :presence

  @@trains = []

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    validate!
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
    if speed.zero? && carriage.type == type
      carriages << carriage
    elsif speed.zero? && carriage.type != type
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
    current_station_index -= 1 if @current_station_index.positive?
    route.stations[current_station_index].add_train(self)
  end

  def all_carriages
    block_given? ? carriages.each(&block) : carriage
  end

  private

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1]
  end
end
