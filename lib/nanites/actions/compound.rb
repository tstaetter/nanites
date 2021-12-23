# frozen_string_literal: true

module Nanites
  module Actions
    # Compounds are queues of nanites, executing each contained
    # nanite, passing the result from an executed as input for the next
    # one
    class Compound
      attr_reader :context

      # Create a new compound
      # @param [Array] nanites optional command objects for initialization. Only accepts [Nanites::Actions::Command]
      #   objects
      def initialize(*nanites)
        @queue = []
        @context = {}

        initialize_queue(nanites) unless nanites.empty?
      end

      # Enqueue a nanite
      # @param [Nanites::Actions::Command] nanite
      def <<(nanite)
        @queue << nanite if nanite.is_a?(Nanites::Actions::Command)
      end

      # Execute the compound
      # @param [Hash] params optional parameters which get passed on to each command
      # @return [Hash] the context hash containing the result for each command
      # :reek:DuplicateMethodCall { max_calls: 3 }
      # :reek:TooManyStatements { max_statements: 6 }
      def execute(**params)
        @queue.each do |cmd|
          cmd.execute(params)
          @context[cmd.id] = cmd.result
        rescue StandardError => e
          @context[cmd.id] = Result.error e, "Error executing command '#{cmd.id}'"
        end

        @context
      end

      private

      # Helper adding given nanites to the queue. Only enqueues [Nanites::Actions::Command] objects
      # @param [Array] nanites Array of command objects
      def initialize_queue(nanites)
        nanites.each do |nanite|
          @queue << nanite if nanite.is_a?(Nanites::Actions::Command)
        end
      end
    end
  end
end
