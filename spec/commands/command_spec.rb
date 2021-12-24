# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Commands::Command do
  it_behaves_like :ClassLoader
  it_behaves_like :Identifyable

  context 'when executed' do
    let :new_result do
      Nanites::Commands::Result.new Nanites::Option.none,
                                   Nanites::Commands::Result::States::UNKNOWN,
                                   'Not yet executed'
    end

    it 'always returns a result object' do
      result = described_class.new.execute

      expect(result.option.none?).to be_truthy
      expect(result.status).to eq new_result.status
      expect(result.messages).to eq new_result.messages
    end
  end

  context 'after execution' do
    it 'has result accessible' do
      cmd = described_class.new
      cmd.execute

      expect(cmd.result.status).to eq Nanites::Commands::Result::States::UNKNOWN
      expect(cmd.result.option).to be_a Nanites::None
    end
  end
end
