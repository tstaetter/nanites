# frozen_string_literal: true

module Nanites
  module Compositions
    # ExecutionGuards are used to determine whether a command within a
    # composition should be executed or not
    class ExecutionGuard
      attr_reader :context, :contract

      # Create Guard
      # @param [Hash] context The current's composition context
      # @param [Nanites::ValidationContracts::NanitesContract] contract optional validation contract
      def initialize(context, contract = nil)
        @context = context || {}
        @contract = contract
      end

      # Determine whether execution of command should be performed
      # @param [Hash] params optional parameters
      # @return [Boolean]
      # @raise [Nanites::Errors::ValidationError] if validation failed
      # @raise [StandardError]
      def execute?(**params)
        validation_errors = validate(**params)
        raise Nanites::Errors::ValidationError, validation_errors unless validation_errors.empty?
      end

      protected

      # Validate given parameters using the instance' validation contract
      # @param [Hash] params The parameters passed on to #execute?
      # @return [Dry::Validation::MessageSet]
      def validate(**params)
        @contract.new.call(params)
      rescue StandardError => _e
        Dry::Validation::MessageSet.new []
      end
    end
  end
end
