# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Nanites do
  it_behaves_like :ClassLoader

  it 'has a version number' do
    expect(Nanites::VERSION).not_to be nil
  end
end
