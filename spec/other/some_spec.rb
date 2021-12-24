# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Some do
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
      end.to raise_error
    end
  end

  context 'when calling value' do
    it 'returns value' do
      some = described_class.new 'foo'

      expect(some.value!).to eq 'foo'
    end

    it 'returns nil value if value was set to nil' do
      some = described_class.new 'foo'
      some.instance_variable_set :'@value', nil

      expect(some.value).to be_nil
    end

    it 'raises ValueError when calling value! on nil value' do
      expect do
        some = described_class.new 'foo'
        some.instance_variable_set :'@value', nil

        some.value!
      end.to raise_error Nanites::Errors::ValueError
    end
  end

  context 'when determining value type' do
    it 'returns true for some?' do
      expect(described_class.new('foo').some?).to be_truthy
    end

    it 'returns false for none?' do
      expect(described_class.new('foo').none?).to be_falsey
    end
  end
end
