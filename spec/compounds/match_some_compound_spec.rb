# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Compounds::MatchSomeCompound do
  it_behaves_like :ClassLoader
  it_behaves_like :Compound, [NoneCommand.new, SomeCommand.new]

  let :command_queue do
    [NoneCommand.new, SomeCommand.new]
  end

  context 'when executed' do
    it 'has only Some results in the context' do
      compound = described_class.new *command_queue
      context = compound.execute!

      context.each_value do |value|
        expect(value.option.some?).to be_truthy
      end
    end
  end
end
