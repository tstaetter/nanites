# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::None do
  it_behaves_like :ClassLoader

  context 'when initializing' do
    it 'can be initialized w/ value' do
      expect do
        described_class.new
      end.to_not raise_error
    end

    it 'can be initialized w/o value' do
      expect do
        described_class.new
      end.to_not raise_error
    end
  end

  context 'when calling value' do
    it 'raises ValueError w/ value' do
      none = described_class.new

      expect do
        none.value!
      end.to raise_error Nanites::Errors::ValueError
    end

    it 'returns nil value if value is present' do
      none = described_class.new

      expect(none.value).to be_nil
    end

    it 'raises ValueError w/o value!' do
      expect do
        described_class.new.value!
      end.to raise_error Nanites::Errors::ValueError
    end
  end

  context 'when determining value type' do
    it 'returns true for some?' do
      expect(described_class.new.some?).to be_falsey
    end

    it 'returns false for none?' do
      expect(described_class.new.none?).to be_truthy
    end
  end
end
