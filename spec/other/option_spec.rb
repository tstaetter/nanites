# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Option do
  it_behaves_like :ClassLoader

  context 'when creating Some' do
    it 'can create a Some object' do
      some = described_class.some 'foo'

      expect(some.value).to eq 'foo'
    end

    it 'creates a Some object from value' do
      val = described_class.option 'foo'

      expect(val.value).to eq 'foo'
    end
  end

  context 'when creating None' do
    it 'can create a None object' do
      none = described_class.none

      expect(none.value).to be_nil
    end

    it 'creates a None object from nil value' do
      val = described_class.option

      expect(val.value).to be_nil
    end
  end
end
