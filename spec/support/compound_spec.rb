# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples_for :Compound do |command_queue|
  context 'when initializing' do
    it 'fails to initialize if no commands are added' do
      expect do
        described_class.new :foo, shall_fail: true
      end.to raise_error Nanites::Errors::NoCommandError
    end

    it 'initializes normally and fails silently if no commands are added' do
      expect do
        described_class.new :foo
      end.to_not raise_error
    end
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
      compound.enqueue SpecCommand.new

      expect(compound.instance_variable_get(:'@queue').size).to eq 1
    end

    it 'has 4 commands after adding 1 to a queue of 3' do
      compound = described_class.new *command_queue
      compound.enqueue SpecCommand.new

      expect(compound.instance_variable_get(:'@queue').size).to eq command_queue.count.next
    end

    it 'has 3 commands after adding 1 non-command to a queue of 3' do
      compound = described_class.new *command_queue
      compound.enqueue :foo_command

      expect(compound.instance_variable_get(:'@queue').size).to eq command_queue.count
    end

    it 'raises error if no command is enqueued' do
      compound = described_class.new *command_queue

      expect do
        compound.enqueue! :foo_command
      end.to raise_error Nanites::Errors::NoCommandError
    end

    it 'can enqueue command with unsaved method' do
      compound = described_class.new *command_queue

      expect do
        compound.enqueue! SpecCommand.new
      end.to_not raise_error
    end
  end
end
