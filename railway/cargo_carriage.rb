class CargoCarriage < Carriage
  def initialize
    super
    @type = :cargo
  end

  def add_cargo(amount)
    raise ERRORS[:not_enough_space] if used_place < amount

    used_place += amount
  end
end
