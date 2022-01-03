# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NoArgsCommand do
  it_behaves_like :ClassLoader

  context 'when executing from class level' do
    it 'returns default payload' do
      expect(described_class.execute.error?).to be_truthy
    end

    it 'returns error result' do
      expect(described_class.execute('foo').error?).to be_truthy
    end
  end
end
