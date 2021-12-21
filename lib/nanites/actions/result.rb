# frozen_string_literal: true

module Nanites
  # Command result
  class Result
    # Defines result status constants
    module States
      UNKNOWN = -1
      SUCCESS = 0
      ERROR = 1
    end

    attr_reader :messages, :payload, :status

    # Create new Result
    # @param [Option] payload
    # @param [Integer] status
    # @param [Array] messages
    # @raise ArgumentError if payload is not of type [Option]
    def initialize(payload, status = States::UNKNOWN, *messages)
      raise ArgumentError, 'Payload must be an "Option"' unless payload.is_a? Option

      @payload = payload
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
      # @param [Object] payload optional payload
      # @param [Array] messages optional informational messages
      # @return [Nanites::Result]
      def error(payload, *messages)
        Result.new option_for_payload(payload), States::ERROR, *messages
      end

      # Create successful result object
      # @param [Object] payload optional payload
      # @param [Array] messages optional informational messages
      # @return [Nanites::Result]
      def success(payload, *messages)
        Result.new option_for_payload(payload), States::SUCCESS, *messages
      end

      private

      # Helper returning an [Option] containing the actual payload
      # @param [Object] payload The value to be wrapped
      # @return [Option]
      def option_for_payload(payload)
        pl = payload || Option.none

        return pl if pl.none?
      rescue NoMethodError
        Option.some(payload)
      end
    end
  end
end
