# frozen_string_literal: true

module Nanites
  module Compounds
    # Compounds are queues of nanites, executing each contained
    # nanite, passing the result from an executed as input for the next
    # one
    class Compound
      attr_reader :context

      # Create a new compound
      # @param [Array] nanites optional command objects for initialization. Only accepts [Nanites::Commands::Command]
      #   objects
      # @param [Boolean] shall_fail Determine whether initialization may fail
      # @raise [Nanites::Errors::NoCommandError] if shall_fail is true
      def initialize(*nanites, shall_fail: false)
        @queue = initialize_queue nanites, shall_fail
        @context = {}
        @filter = nil
      end

      # Enqueue a nanite. Silently fail, if nanite is not a command
      # @param [Nanites::Commands::Command] nanite
      def enqueue(nanite)
        @queue << nanite if nanite.is_a?(Nanites::Commands::Command)
      end

      # Enqueue a nanite
      # @param [Nanites::Commands::Command] nanite
      # @raise [Nanites::Errors::NoCommandError] if nanite isn't a [Nanites::Commands::Command]
      def enqueue!(nanite)
        unless nanite.is_a?(Nanites::Commands::Command)
          raise Nanites::Errors::NoCommandError, 'Given nanite is not a command'
        end

        @queue << nanite
      end

      # Execute the compound. Errors are added to the context.
      # @param [Hash] params optional parameters which get passed on to each command
      # @return [Hash] the context hash containing the result for each command
      # :reek:DuplicateMethodCall { max_calls: 3 }
      # :reek:TooManyStatements { max_statements: 6 }
      def execute(**params)
        @context = @queue.map do |cmd|
          run cmd, **params
        rescue StandardError => e
          [cmd.id, Nanites::Commands::Result.error(e, "Error executing command '#{cmd.id}'")]
        end.delete_if { |item| item.length != 2 }.to_h
      end

      # Execute the compound
      # @param [Hash] params optional parameters which get passed on to each command
      # @return [Hash] the context hash containing the result for each command
      # :reek:DuplicateMethodCall { max_calls: 3 }
      # :reek:TooManyStatements { max_statements: 6 }
      def execute!(**params)
        @context = @queue.map do |cmd|
          run cmd, **params
        end.delete_if { |item| item.length != 2 }.to_h
      end

      protected

      # Helper actually performing the command
      # @param [Nanites::Commands::Command] cmd
      # @param [Hash] params optional parameters
      # @return [Array]
      # :reek:DuplicateMethodCall
      # :reek:FeatureEnvy
      def run(cmd, **params)
        cmd.execute(**params)
        result = [cmd.id, cmd.result]

        if @filter
          @filter&.call(cmd.result) ? result : []
        else
          result
        end
      end

      # Helper adding given nanites to the queue. Only enqueues [Nanites::Commands::Command] objects
      # @param [Array] nanites Array of command objects
      # @param [Boolean] shall_fail Determine whether initialization may fail
      def initialize_queue(nanites, shall_fail)
        nanites.select do |nanite|
          is_command = nanite.is_a?(Nanites::Commands::Command)

          raise Nanites::Errors::NoCommandError, 'Given nanite is not a command' if
            shall_fail && !is_command

          nanite if !shall_fail && is_command
        end
      end
    end
  end
end
