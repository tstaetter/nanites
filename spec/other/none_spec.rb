# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::None do
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
    it 'raises ValueError w/ value' do
      none = described_class.new 'foo'

      expect do
        none.value
      end.to raise_error Nanites::Errors::ValueError
    end

    it 'raises ValueError w/o value' do
      expect do
        described_class.new.value
      end.to raise_error Nanites::Errors::ValueError
    end
  end
end
