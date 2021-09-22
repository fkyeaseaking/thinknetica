require_relative "company_mixin.rb"

class Carriage
  include CompanyMixin

  attr_reader :type
end
