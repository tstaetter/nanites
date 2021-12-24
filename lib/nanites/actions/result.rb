# frozen_string_literal: true

module Nanites
  module Actions
    # Command result
    class Result
      # Defines result status constants
      module States
        UNKNOWN = nil
        SUCCESS = true
        ERROR = false

        class << self
          # Is given code a valid status code?
          # @return [Boolean]
          def valid_status?(code)
            constants(false).each do |constant|
              return true if States.const_get(constant).eql?(code)
            end

            false
          end
        end
      end

      attr_reader :messages, :option, :status

      # Create new Result
      # @param [Option] option
      # @param [Integer] status
      # @param [Array] messages
      # @raise [ArgumentError] if payload is not of type [Nanites::Option]
      # @raise [ArgumentError] if status code is not supported
      def initialize(option, status = States::UNKNOWN, *messages)
        raise ArgumentError, 'Payload must be an "Option"' unless option.is_a?(Nanites::Option)
        raise ArgumentError, "Unknown status code '#{status}'" unless States.valid_status?(status)

        @option = option
        @messages = messages
        @status = status
      end

      # Does the result indicate some error?
      def error?
        @status.eql? States::ERROR
      end

      # Does the result indicate successful command execution?
      def success?
        @status.eql? States::SUCCESS
      end

      class << self
        # Create result object indicating an erroneous command execution
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
          value ? Option.some(value) : Option.none
        end
      end
    end
  end
end
