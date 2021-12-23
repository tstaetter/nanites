# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SpecCommand do
  context 'when executed w/o payload' do
    it 'can execute w/o raising error' do
      expect do
        described_class.execute
      end.to_not raise_error
    end

    it 'returns error as result status w/o parameters' do
      expect(described_class.execute.error?).to be_truthy
    end

    it 'returns single message w/o parameters' do
      expect(described_class.execute.messages).to eq ['No parameters defined']
    end

    it 'returns success as result status w/ parameters' do
      expect(described_class.execute(foo: :bar, lorem: :ipsum).success?).to be_truthy
    end

    it 'returns one message per given parameter' do
      params = { foo: :bar, lorem: :ipsum }
      expected_messages = params.map { |k, v| "#{k} => #{v}" }

      expect(described_class.execute(foo: :bar, lorem: :ipsum).messages).to eq expected_messages
    end
  end
end
