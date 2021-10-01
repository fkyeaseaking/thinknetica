require_relative "company_mixin"
require_relative "accessors_mixin"
require_relative "validation_mixin"

class Carriage
  include CompanyMixin
  include Validation
  extend Accessors

  attr_reader :type
  attr_accessor_with_history :number, :place, :used_place
  validate :place, :type, Integer

  ERRORS = {
    all_seats_taken: "All seats taken",
    not_enough_space: "Not enough space"
  }.freeze

  def initialize(place)
    @place = place
    @used_place = 0
    @number = rand(1..1000)
    validate!
  end

  def free_place
    place - used_place
  end
end
