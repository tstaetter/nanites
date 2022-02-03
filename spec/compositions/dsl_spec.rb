# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites::Compositions::DSL do
  it_behaves_like :ClassLoader

  context 'when using Nanites namespace' do
    it 'has #compose in namespace' do
      expect(Nanites.respond_to?(:compose)).to be_truthy
    end
  end

  context 'when using DSL' do
    let :order do
      JSON.load_file 'spec/fixtures/order.json'
    end

    pending 'can create composition' do
      composition = Nanites.compose payload: order do
        add NoArgsCommand.new(foo: :bar), if: -> (context) { context[:customer][:email] =~ EMAIL_REGEX }
      end

      expect(composition).to be_a Nanites::Compositions::Composition
    end

    it 'can run composition' do
      result = Nanites.compose payload: order do
        add NoArgsCommand.new(foo: :bar), if: -> (context) { context[:customer][:email] =~ EMAIL_REGEX }
      end.run

      expect(result.success?).to be_truthy
    end
  end
end
