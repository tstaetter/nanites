# frozen_string_literal: true

module Nanites
  module Commands
    # Abstract Nanite command class
    # @abstract
    class Command
      attr_reader :id, :result

      # Create new Command object
      # @param [Object] payload optional payload
      def initialize(payload = nil)
        @id = SecureRandom.uuid
        @payload = payload
        @result = not_started_result
      end

      # Execute the nanite
      # @abstract
      # @param [Hash] _params Optional arguments
      # @return [Nanites::Commands::Result]
      def execute(**_params)
        @result
      end

      class << self
        # Static helper method, instantiating new Command object and running it's
        # execute methods
        # @param [Object] payload optional payload
        # @param [Hash] params optional parameters
        # @return [Result]
        def execute(payload = nil, **params)
          cmd = new(payload)
          cmd.execute(**params)

          cmd.result
        rescue StandardError => e
          Result.error e, "Error executing command with payload '#{payload}'"
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

      private

      # Helper returning a result indicating that this command hasn't yet been executed
      def not_started_result
        Result.new Option.none, Result::States::UNKNOWN, 'Not yet executed'
      end
    end
  end
end
