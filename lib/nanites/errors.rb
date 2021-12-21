# frozen_string_literal: true

module Nanites
  # Defines all custom error classes
  module Errors
    # Is raised, when a None option is tried to be unwrapped
    class ValueError < StandardError; end
  end
end
