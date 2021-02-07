# frozen_string_literal: true

module Validation
  VALIDATOR_KINDS = %i[presence format type].freeze

  module ClassMethods
    def validate(attribute, **options)
      @validators ||= []
      options.each do |kind, option|
        case kind
        when :presence
          unless option.is_a?(TrueClass) || option.is_a?(FalseClass)
            raise StandardError,
                  "Validation #{self}.#{attribute}, Boolean required"
          end
        when :format
          raise StandardError, "Validation #{self}.#{attribute}, regexp required" unless option.is_a? Regexp
        when :type
          raise StandardError, "Validation #{self}.#{attribute}, Class required" unless option.is_a? Class
        else
          raise NotImplementedError, "Validation #{kind} doesnt allowed"
        end
        @validators << { attribute: attribute, kind: kind, option: option }
      end
    end
  end

  def self.included(klass)
    klass.extend ClassMethods
  end

  def validate!
    validators = self.class.instance_variable_get :@validators
    validators.each do |validator|
      unless VALIDATOR_KINDS.include? validator[:kind]
        raise NotImplementedError,
              "Validation #{validator[:kind]} doesnt allowed"
      end

      send "validate_#{validator[:kind]}", validator[:attribute], validator[:option]
    end
    nil
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate_presence(attribute, presence)
    if presence
      raise_validation_error "#{attribute} should be defined" if (attribute_value(attribute).nil? || attribute_value(attribute) == '')
    else
      raise_validation_error "#{attribute} should not be defined" unless attribute_value(attribute).nil?
    end
  end

  def validate_format(attribute, format)
    raise_validation_error "#{attribute} should be a string" unless attribute_value(attribute).is_a? String
    raise_validation_error "#{attribute} should match #{format}" unless format.match? attribute_value(attribute)
  end

  def validate_type(attribute, klass)
    unless attribute_value(attribute).instance_of?(klass)
      raise_validation_error("#{attribute} should be an instance of #{klass}")
    end
  end

  def raise_validation_error(message)
    raise StandardError, message
  end

  def attribute_value(attribute)
    instance_variable_get "@#{attribute}".to_sym
  end
end
