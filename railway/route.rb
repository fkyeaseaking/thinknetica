require_relative "instance_counter.rb"
require_relative "validation_check_mixin.rb"


class Route
  include InstanceCounter
  include ValidationCheckMixin

  attr_reader :stations

  ERRORS = {
    invalid_station: "Invalid station"
  }

  init_instances

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    stations.insert(@stations.size - 1, station)
    validate!
  end

  def remove_station(station)
    stations.delete(station)
  end

  private
  
  def validate!
    stations.each { |station| raise ERRORS[:invalid_station] if station.class != Station }
    true
  end
end
