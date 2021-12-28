# frozen_string_literal: true

module Nanites
  # Defines all custom error classes
  module Errors
    # Is raised, when a None option is tried to be unwrapped
    class ValueError < StandardError; end

    # Is raised, when a None option is tried to be unwrapped
    class NoCommandError < StandardError; end

    # Is raised, when validation fails at some stage
    class ValidationError < StandardError; end
  end
end
