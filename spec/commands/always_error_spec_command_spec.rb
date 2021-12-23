# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AlwaysErrorCommand do
  context 'when executed' do
    it 'returns Result' do
      expect(described_class.execute.option.value).to be_a StandardError
    end
  end
end
