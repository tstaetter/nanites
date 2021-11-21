# frozen_string_literal: true

module Nanites
  module Actions
    # Abstract nanite class
    # @abstract
    #
    class Command
      attr_reader :result

      def initialize(event)
        @event = event
        @result = Option.none
      end

      ##
      # Execute the nanite
      # @abstract
      # @param [Hash] _params Optional arguments
      # @raise StandardError
      #
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
      def success!(payload, *messages)
        @result = Result.create_success payload, *messages
      end

      # Set the nanites output to a erroneous result
      # @param [Array] messages Optional array of informational messages
      # @param [Hash] payload Optional payload stored within the result
      def error!(messages = [], payload = {})
        @result = Result.create_error payload, *messages
      end
    end
  end
end
