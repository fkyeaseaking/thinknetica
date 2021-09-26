class PassengerCarriage < Carriage
  attr_reader :seats_taken, 

  def initialize(seats_max)
    super
    @seats_max = seats_max
    @seats_taken = 0
    @type = :passenger
  end

  def add_passenger
    if seats_taken < seats_max
      seats_taken += 1 
    else
      raise ERRORS[:all_seats_taken]
    end
  end

  def free_seats
    seats_max - seats_taken
  end
end
