class CargoCarriage < Carriage
  def initialize
    super
    @type = :cargo
  end

  def add_cargo(amount)
    if used_place < amount
      raise ERRORS[:not_enough_space]
    else
      place += amount
    end
  end
end
