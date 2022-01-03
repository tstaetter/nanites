# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SimpleCommand do
  it_behaves_like :ClassLoader

  context 'after initialization' do
    let :uuid_pattern do
      /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
    end

    it 'has a unique identifier set' do
      expect(described_class.new('foo').executable_id).to be =~ uuid_pattern
    end

    it 'has the unique identifier frozen' do
      expect(described_class.new('foo').executable_id.frozen?).to be_truthy
    end

    it 'has default payload set to Option.none' do
      expect(described_class.new('foo').payload.none?).to be_truthy
    end

    it 'has default result set to unknown' do
      expect(described_class.new('foo').result.status).to eq Nanites::Commands::Result::States::UNKNOWN
    end

    it 'has class specific instance variables set' do
      expect(described_class.new('foo').test_name).to eq 'foo'
    end
  end

  context 'when executing from instance level' do
    it 'returns success payload' do
      expect(described_class.new('foo').execute.option.value).to eq 'I am the success payload'
    end
  end

  context 'when executing from class level' do
    it 'returns success payload' do
      expect(described_class.execute('foo').option.value).to eq 'I am the success payload'
    end
  end
end
