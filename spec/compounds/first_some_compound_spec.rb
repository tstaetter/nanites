# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Compounds::FirstSomeCompound do
  it_behaves_like :ClassLoader
  it_behaves_like :Compound, [NoneCommand.new, SomeCommand.new]

  let :command_queue do
    [NoneCommand.new, SomeCommand.new]
  end

  context 'when executed' do
    it 'returns one Some result with unsave execution' do
      compound = described_class.new *command_queue
      option = compound.execute!

      expect(option.some?).to be_truthy
    end

    it 'returns one Some result with save execution' do
      compound = described_class.new *command_queue
      option = compound.execute

      expect(option.some?).to be_truthy
    end

    it 'raises error when command raises one' do
      compound = described_class.new AlwaysErrorCommand.new

      expect do
        compound.execute!
      end.to raise_error StandardError
    end

    it 'returns None if error was raised' do
      compound = described_class.new AlwaysErrorCommand.new
      option = compound.execute

      expect(option.none?).to be_truthy
    end

    it 'returns None if no command returned Some with save execution' do
      compound = described_class.new NoneCommand.new
      option = compound.execute

      expect(option.none?).to be_truthy
    end

    it 'returns None if no command returned Some with unsave execution' do
      compound = described_class.new NoneCommand.new
      option = compound.execute!

      expect(option.none?).to be_truthy
    end
  end
end
