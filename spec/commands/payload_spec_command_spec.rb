# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PayloadSpecCommand do
  context 'when executed w/ payload' do
    it 'can execute w/o raising error' do
      expect do
        described_class.execute 'payload', foo: :bar
      end.to_not raise_error
    end

    it 'returns error as result status w/ nil payload' do
      expect(described_class.execute(nil).error?).to be_truthy
    end

    it 'returns single message w/ nil payload' do
      expect(described_class.execute(nil).messages).to eq ['Got nil as payload']
    end

    it 'returns success as result status w/ payload' do
      expect(described_class.execute('foobar').success?).to be_truthy
    end

    it 'returns payload type in a message' do
      expected_messages = ['Got a String object as payload']

      expect(described_class.execute('foobar').messages).to eq expected_messages
    end
  end

  context 'after execution' do
    it 'has result accessible' do
      cmd = described_class.new('foobar')
      cmd.execute

      expect(cmd.result.option.value).to eq 'foobar'
    end
  end
end
