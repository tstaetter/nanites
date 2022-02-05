# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Compositions::Composition do
  it_behaves_like :ClassLoader

  context 'when initializing' do
    it 'accepts several command instances' do
      composition = described_class.new NoArgsCommand.new, NoArgsCommand.new
      expect(composition.commands.count).to eq 2
    end

    it 'accepts several command classes' do
      composition = described_class.new SimpleCommand, NoArgsCommand
      expect(composition.commands.count).to eq 2
    end

    it 'can be created w/o commands' do
      expect(described_class.new.commands.count).to eq 0
    end
  end

  context 'after initialization' do
    let :composition do
      described_class.new
    end

    it 'can be added new command objects using' do
      composition.add NoArgsCommand
      composition << NoArgsCommand
      composition.add NoArgsCommand

      expect(composition.commands.count).to eq 3
    end

    it 'can run block' do
      tester = ''
      described_class.new NoArgsCommand, foo: :bar do
        tester = 'block executed'
      end

      expect(tester).to eq 'block executed'
    end
  end

  context 'when running' do
    let :instance do
      described_class.new
    end

    it 'always returns a result' do
      expect(instance.run.respond_to?(:option)).to be_truthy
    end

    it 'returns success if run was successful' do
      context = { foo: :bar }
      composition = described_class.new CompostionCommand.new(:foo, :bar), foo: :bar
      composition.add CompostionCommand.new(:lorem, :ipsum)
      composition.add CompostionCommand.new(:blub, :lall)
      result = composition.run

      expect(result.success?).to be_truthy
    end
  end
end
