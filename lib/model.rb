# frozen_string_literal: true

class Model
  def initialize(**params)
    params.each do |param, value|
      add_attribute param, value
    end
  end

  def set_attribute(param, value)
    if instance_variables.include? "@#{param}".to_sym
      instance_variable_set "@#{name}".to_sym, value
    else
      add_attribute param, value
    end
  end

  private

  def add_attribute(name, value)
    define_singleton_method name.to_sym do
      instance_variable_get "@#{name}"
    end
    define_singleton_method "#{name}=".to_sym do |val|
      instance_variable_set "@#{name}", val
    end
    instance_variable_set "@#{name}".to_sym, value
  end
end
