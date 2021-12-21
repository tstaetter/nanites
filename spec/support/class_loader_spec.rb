# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples_for :ClassLoader do
  context 'when loading classes' do
    it 'loads class' do
      expect do
        described_class
      end.to_not raise_error
    end
  end
end
