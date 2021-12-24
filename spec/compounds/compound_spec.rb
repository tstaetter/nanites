# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Compounds::Compound do
  it_behaves_like :ClassLoader
  it_behaves_like :Compound, [SpecCommand.new, PayloadSpecCommand.new('foo'), AlwaysErrorCommand.new]

  let :command_queue do
    [SpecCommand.new, PayloadSpecCommand.new('foo'), AlwaysErrorCommand.new]
  end

  context 'when executing' do
    it 'has a result for each command available' do
      compound = described_class.new *command_queue
      context = compound.execute

      command_queue.each do |cmd|
        expect(context[cmd.id]).to be_a Nanites::Commands::Result
      end
    end

    it 'raises an error if one command raises one' do
      compound = described_class.new *command_queue

      expect do
        compound.execute!
      end.to raise_error StandardError
    end
  end
end
