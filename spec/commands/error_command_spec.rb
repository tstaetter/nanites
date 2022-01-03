# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ErrorCommand do
  it_behaves_like :ClassLoader

  context 'when executing from instance level' do
    it 'returns error payload' do
      result = described_class.new.execute('foo')
      expect(result.error?).to be_truthy
    end
  end

  context 'when executing from class level' do
    it 'returns default payload' do
      expect(described_class.execute.error?).to be_truthy
    end

    it 'returns error result' do
      expect(described_class.execute('foo').error?).to be_truthy
    end

    it 'returns success result' do
      expect(described_class.execute('foo', 'bar').success?).to be_truthy
    end
  end
end
