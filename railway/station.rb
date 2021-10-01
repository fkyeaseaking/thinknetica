require_relative "instance_counter"
require_relative "accessors_mixin"
require_relative "validation_mixin"

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor_with_history :trains
  strong_attr_accessor :name, String
  validate :name, :presence
  validate :name, :type, String

  init_instances

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    register_instance
    @@stations << self
  end

  def self.all
    @@stations
  end

  def all_trains
    block_given? ? trains.each(&block) : trains
  end

  def add_train(train)
    trains << train
  end

  def send_train(train)
    trains.delete(train)
  end
end
