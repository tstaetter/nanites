# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Actions::Compound do
  it_behaves_like :ClassLoader

  let :command_queue do
    [SpecCommand.new, PayloadSpecCommand.new('foo'), AlwaysErrorCommand.new]
  end

  context 'after initialization' do
    it 'has correct queue size' do
      compound = described_class.new *command_queue
      expect(compound.instance_variable_get(:'@queue').size).to eq command_queue.length
    end

    it 'has an empty queue when initialized w/o nanites' do
      expect(described_class.new.instance_variable_get(:'@queue').size).to eq 0
    end

    it 'has an empty queue when initialized w/ non-nanites' do
      compound = described_class.new :foo, :bar
      expect(compound.instance_variable_get(:'@queue').size).to eq 0
    end

    it 'has an empty context object' do
      expect(described_class.new.instance_variable_get(:'@context').size).to eq 0
    end
  end

  context 'when enqueuing commands' do
    it 'has 1 command in queue after adding 1 to an empty queue' do
      compound = described_class.new
      compound << SpecCommand.new

      expect(compound.instance_variable_get(:'@queue').size).to eq 1
    end

    it 'has 4 commands after adding 1 to a queue of 3' do
      compound = described_class.new *command_queue
      compound << SpecCommand.new

      expect(compound.instance_variable_get(:'@queue').size).to eq 4
    end

    it 'has 3 commands after adding 1 non-command to a queue of 3' do
      compound = described_class.new *command_queue
      compound << :foo_command

      expect(compound.instance_variable_get(:'@queue').size).to eq 3
    end
  end

  context 'when executing' do
    it 'has a result for each command available' do
      compound = described_class.new *command_queue
      context = compound.execute

      command_queue.each do |cmd|
        expect(context[cmd.id]).to be_a Nanites::Actions::Result
      end
    end
  end
end
