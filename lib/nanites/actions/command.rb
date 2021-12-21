# frozen_string_literal: true

module Nanites
  module Actions
    # Abstract Nanite command class
    # @abstract
    class Command
      attr_reader :result

      def initialize(event)
        @event = event
        @result = Option.none
      end

      # Execute the nanite
      # @abstract
      # @param [Hash] _params Optional arguments
      def execute(**_params)
        raise NotImplementedError, 'Implement in specialized class'
      end

      class << self
        # Static helper method, instantiating new nanite object and running it's
        # execute methods
        def execute(event, **params)
          new(event).execute(**params)
        end
      end

      protected

      # Set the nanites output to a successful result
      # @param [Object] payload Optional payload stored within the result
      # @param [Array] messages Optional array of informational messages
      def success(payload, *messages)
        @result = Result.success payload, *messages
      end

      # Set the nanites output to a erroneous result
      # @param [Object] payload Optional payload stored within the result
      # @param [Array] messages Optional array of informational messages
      def error(payload, *messages)
        @result = Result.error payload, *messages
      end
    end
  end
end
