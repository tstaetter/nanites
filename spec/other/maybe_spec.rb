# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Maybe do
  it_behaves_like :ClassLoader

  context 'when initializing' do
    it 'can be initialized w/ value' do
      expect do
        described_class.new 'foo'
      end.to_not raise_error
    end

    it 'can be initialized w/o value' do
      expect do
        described_class.new
      end.to_not raise_error
    end
  end

  context 'when calling value' do
    it 'returns value' do
      maybe = described_class.new 'foo'

      expect(maybe.value!).to eq 'foo'
    end

    it 'returns nil value if value was set to nil' do
      maybe = described_class.new nil

      expect(maybe.value).to be_nil
    end

    it 'raises ValueError when calling value! on nil value' do
      expect do
        maybe = described_class.new nil

        maybe.value!
      end.to raise_error Nanites::Errors::ValueError
    end

    it 'returns true when calling value? and value is set' do
      expect(described_class.new('foo').value?).to be_truthy
    end

    it 'returns false when calling value? and no value is set' do
      expect(described_class.new.value?).to be_falsey
    end
  end

  context 'when determining value type' do
    it 'returns true for maybe?' do
      expect(described_class.new('foo').maybe?).to be_truthy
    end

    it 'returns false for none?' do
      expect(described_class.new('foo').none?).to be_falsey
    end

    it 'returns false for some?' do
      expect(described_class.new('foo').some?).to be_falsey
    end
  end
end
