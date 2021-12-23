# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples_for :Identifyable do
  context 'after initialization' do
    let :uuid_pattern do
      /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
    end

    it 'has a unique identifier set' do
      expect(described_class.new.id).to be =~ uuid_pattern
    end
  end
end
