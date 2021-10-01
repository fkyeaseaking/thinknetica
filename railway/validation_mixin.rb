module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validate_form

    def validate(name, type, *args)
      @validate_form ||= []
      @validate_form.push([name, type, args])
    end
  end

  module InstanceMethods
    def validate!
      self.class.validate_form.each do |name, type, args|
        errors = []
        var = instance_variable_get("@#{name}".to_sym)

        case type
        when :presence
          errors << "#{name} is not present." if var.nil?
        when :format
          errors << "#{name} is not fit #{args.to_s} format." unless var =~ args[0]
        when :type
          errors << "#{name} is not #{args.to_s}." unless var.instance_of?(args[0])
        end

        raise errors.join(" ") unless errors.empty?
      end
    end

    def valid?
      !!validate!
    rescue StandardError
      false
    end
  end
end
