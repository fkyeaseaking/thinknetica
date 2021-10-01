module Accessors
  def attr_accessor_with_history(*methods)
    methods.each do |method|
      var_name = "@#{method}".to_sym
      history_var_name = "@#{method}_history".to_sym
      history = []

      define_method(method) do
        instance_variable_get(var_name)
      end

      define_method("#{method}=") do |v|
        history << v
        instance_variable_set(history_var_name, history)
        instance_variable_set(var_name, v)
      end

      define_method("#{method}_history") do
        instance_variable_get(history_var_name)
      end
    end
  end

  def strong_attr_accessor(method, type)
    var_name = "@#{method}".to_sym

    define_method(method) do
      instance_variable_get(var_name)
    end

    define_method("#{method}=") do |v|
      raise TypeError unless v.instance_of? type

      instance_variable_set(var_name, v)
    end
  end
end
