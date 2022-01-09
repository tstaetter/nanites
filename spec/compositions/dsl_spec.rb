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
    let :payload do
      JSON.load_file 'spec/fixtures/order.json'
    end

    pending 'can create composition' do
      composition = Nanites.compose payload: order do
        add MyCommand, if: -> (context) { context[:customer][:email] =~ EMAIL_REGEX }
      end

      expect(composition).to be_a Nanites::Compositions::Composition
    end
  end
end
