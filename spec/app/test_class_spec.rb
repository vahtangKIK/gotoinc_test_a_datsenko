# frozen_string_literal: true

require 'spec_helper'
require 'pry'
require_relative '../../app/test_class'

RSpec.describe ::TestClass do
  context 'methods including' do
    it 'as class method' do
      expect(described_class).to respond_to :validate
    end

    it { is_expected.to respond_to(:validate!) }
    it { is_expected.to respond_to(:valid?) }
  end

  context 'valid attributes' do
    let!(:instance) { described_class.new(name: 'valid name', number: 'ABC', owner: User.new) }

    it 'has 3 validators' do
      expect(instance.class.instance_variable_get(:@validators).size).to eq 3
    end

    it 'doesnt rise error on validate!' do
      expect { instance.validate! }.to_not raise_error
    end

    it 'is valid?' do
      expect(instance.valid?).to eq true
    end
  end

  context 'name is blank' do
    let!(:instance) { described_class.new(number: 'ABC', owner: User.new) }

    it 'rises error on validate!' do
      expect { instance.validate! }.to raise_error(StandardError, 'name should be defined')
    end

    it 'isnt valid?' do
      expect(instance.valid?).to eq false
    end
  end

  context 'number is inappropriate' do
    let!(:instance) { described_class.new(name: 'valid name', number: '12345', owner: ::User.new) }

    it 'rises error on validate!' do
      expect { instance.validate! }.to raise_error(StandardError, 'number should match (?-mix:[A-Z]{1,3})')
    end

    it 'isnt valid?' do
      expect(instance.valid?).to eq false
    end
  end

  context 'owner is not an User instance' do
    let!(:instance) { described_class.new(name: 'valid name', number: 'ABC', owner: ::Admin.new) }

    it 'rises error on validate!' do
      expect { instance.validate! }.to raise_error(StandardError, 'owner should be an instance of User')
    end

    it 'isnt valid?' do
      expect(instance.valid?).to eq false
    end
  end
end
