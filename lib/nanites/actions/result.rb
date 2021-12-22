# frozen_string_literal: true

module Nanites
  module Actions
    # Command result
    class Result
      # Defines result status constants
      module States
        UNKNOWN = -1
        SUCCESS = 0
        ERROR = 1
      end

      attr_reader :messages, :value, :status

      # Create new Result
      # @param [Option] value
      # @param [Integer] status
      # @param [Array] messages
      # @raise ArgumentError if payload is not of type [Option]
      def initialize(value, status = States::UNKNOWN, *messages)
        raise ArgumentError, 'Payload must be an "Option"' unless value.is_a? Option

        @value = value
        @messages = messages
        @status = status
      end

      def error?
        @status.eql? States::ERROR
      end

      def success?
        @status.eql? States::SUCCESS
      end

      class << self
        # Create erroneous result object
        # @param [Object] value optional payload
        # @param [Array] messages optional informational messages
        # @return [Nanites::Result]
        def error(value, *messages)
          Result.new option_for_payload(value), States::ERROR, *messages
        end

        # Create successful result object
        # @param [Object] value optional payload
        # @param [Array] messages optional informational messages
        # @return [Nanites::Result]
        def success(value, *messages)
          Result.new option_for_payload(value), States::SUCCESS, *messages
        end

        private

        # Helper returning an [Option] containing the actual payload
        # @param [Object] value The value to be wrapped
        # @return [Option]
        def option_for_payload(value)
          pl = value || Option.none

          return pl if pl.none?
        rescue NoMethodError
          Option.some(value)
        end
      end
    end
  end
end
