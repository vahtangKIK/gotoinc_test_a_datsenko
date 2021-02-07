# frozen_string_literal: true

require 'model'
require 'validation'
require_relative './user'
require_relative './admin'

class TestClass < Model
  include Validation
  validate :name, presence: true
  validate :number, format: /[A-Z]{1,3}/
  validate :owner, type: User
end
