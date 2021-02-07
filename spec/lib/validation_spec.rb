# frozen_string_literal: true

# frozen_string_literals: true

require 'spec_helper'
require 'validation'

RSpec.describe ::Validation do
  it '.validate' do
    expect(described_class::ClassMethods.public_method_defined?(:validate)).to be_truthy
  end

  it '.validate!' do
    expect(described_class.public_method_defined?(:validate!)).to be_truthy
  end

  it '.valid?' do
    expect(described_class.public_method_defined?(:valid?)).to be_truthy
  end
end
