# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples_for :HasExecutableProperties do |klazz|
  context 'after initialization' do
    let :uuid_pattern do
      /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
    end

    it 'has a unique identifier set' do
      expect(klazz.new.id).to be =~ uuid_pattern
    end

    it 'has default payload set to Option.none' do
      expect(klazz.new.payload.none?).to be_truthy
    end

    it 'has default result set to unknown' do
      expect(klazz.new.result.status).to eq Nanites::Commands::Result::States::UNKNOWN
    end
  end
end
