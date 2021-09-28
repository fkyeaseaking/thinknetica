require_relative "instance_counter"
require_relative "validation_check_mixin"

class Station
  include InstanceCounter
  include ValidationCheckMixin

  attr_reader :name, :trains

  ERRORS = {
    empty_name: "Name can not be empty"
  }.freeze

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

  private

  def validate!
    raise ERRORS[:empty_name] if name.empty?

    true
  end
end
