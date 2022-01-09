# frozen_string_literal: true

module Nanites
  # Defines all custom error classes
  module Errors
    # Is raised, when an inappropriate value is used
    class ValueError < StandardError; end

    # Is raised, if a command execution fails
    class ExecutionError < StandardError; end
  end
end
