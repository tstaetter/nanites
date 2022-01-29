# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Result do
  it_behaves_like :ClassLoader

  let :none do
    Nanites::Option.none
  end

  let :some do
    Nanites::Option.some 'foo'
  end

  context 'when initializing' do
    it 'can be initialized with None option' do
      expect do
        described_class.new none
      end.to_not raise_error
    end

    it 'can be initialized with Some option' do
      expect do
        described_class.new some
      end.to_not raise_error
    end

    it 'raises ArgumentError if option is not an Option' do
      expect do
        described_class.new 'foo'
      end.to raise_error ArgumentError
    end

    it 'raises ArgumentError if status is unknown' do
      expect do
        described_class.new some, 10
      end.to raise_error ArgumentError
    end
  end

  context 'when using helper methods' do
    it 'creates a result with a Some Option' do
      expect(described_class.success('foo').option).to be_a Nanites::Some
    end

    it 'creates a result with a Some Option and stores the value correctly' do
      value = described_class.success('foo').option.value
      expect(value).to eq 'foo'
    end

    it 'creates a result with a None Option' do
      expect(described_class.success(nil).option).to be_a Nanites::None
    end
  end

  context 'when accessing option value' do
    it 'returns payload for Some option using safe value method' do
      result = described_class.success'foo'
      expect(result.option.value).to eq 'foo'
    end

    it 'returns payload for Some option using unsafe value! method' do
      result = described_class.success'foo'
      expect(result.option.value!).to eq 'foo'
    end

    it 'returns nil for None option using safe value method' do
      result = described_class.success nil
      expect(result.option.value).to eq nil
    end

    it 'returns payload for Some option using unsafe value! method' do
      result = described_class.success nil
      expect do
        result.option.value!
      end.to raise_error Nanites::Errors::ValueError
    end
  end

  context 'when determining Option type' do
    it 'returns Some for not nil value' do
      expect(described_class.send(:option_for_payload, 'foo').some?).to be_truthy
    end

    it 'returns None for nil value' do
      expect(described_class.send(:option_for_payload, nil).none?).to be_truthy
    end

    it 'returns Some for empty String value' do
      expect(described_class.send(:option_for_payload, '').some?).to be_truthy
    end

    it 'returns Some for empty Enumerable value' do
      expect(described_class.send(:option_for_payload, []).some?).to be_truthy
    end
  end

  context 'when determining status' do
    it 'returns true for result indicating an error' do
      result = described_class.error 'foo'
      expect(result.error? && !result.success? && !result.unknown?).to be_truthy
    end

    it 'returns true for result indicating no error' do
      result = described_class.success 'foo'
      expect(!result.error? && result.success? && !result.unknown?).to be_truthy
    end

    it 'returns true for result indicating unknown status' do
      result = described_class.unknown
      expect(!result.error? && !result.success? && result.unknown?).to be_truthy
    end

    it 'returns true for known status' do
      described_class::States.constants(false).each do |state|
        value = described_class::States.const_get state
        expect(described_class::States.valid_status?(value)).to be_truthy
      end
    end

    it 'returns false for unknown status' do
      expect(described_class::States.valid_status?(:foo)).to be_falsey
    end
  end
end
