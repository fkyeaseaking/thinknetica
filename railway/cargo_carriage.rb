class CargoCarriage < Carriage
  attr_reader :cargo_volume

  def initialize(capacity)
    super
    @capacity = capacity
    @type = :cargo
    @cargo_volume = 0
  end

  def add_cargo(volume)
    if space_left < volume
      raise ERRORS[:not_enough_space]
    else
      cargo_volume += volume
    end
  end

  def space_left
    capacity - cargo_volume
  end
end
