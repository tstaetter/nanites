# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ErrorCommand do
  it_behaves_like :ClassLoader

  context 'when executing from instance level' do
    it 'returns error payload' do
      result = described_class.new.execute('foo')
      expect(result.error?).to be_truthy
    end

    it 'raises ExecutionError when calling unsafe method' do
      expect do
        described_class.new.execute!
      end.to raise_error Nanites::Errors::ExecutionError
    end
  end

  context 'when executing from class level' do
    it 'returns default payload' do
      expect(described_class.execute.error?).to be_truthy
    end

    it 'raises ExecutionError when calling unsafe method' do
      expect(described_class.execute.error?).to be_truthy
    end
  end
end
