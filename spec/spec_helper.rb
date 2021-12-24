# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/.idea/'
end

require 'nanites'
require 'support/class_loader_spec'
require 'support/compound_spec'
require 'support/identifyable_spec'
require 'support/spec_command'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
