# frozen_string_literal: true

module Nanites
  module Compositions
    # Composition combines several commands and uses guards to determine
    # whether a command should be executed
    class Composition
      attr_reader :commands

      def initialize(*commands, **context, &blk)
        @commands = initialize_commands commands
        @_context = context

        blk.call if block_given?
      end

      # Add a command. Order matters, commands are executed in FIFO order
      # Add execution guards using 'if:' parameter
      # @example
      #   ```
      #     c = Composition.new
      #     c.add MyCommand, if: -> (context) { context[:customer][:email] =~ EMAIL_REGEX }
      #   ```
      # @param [Object] command A command class adding the [Nanites::Commands::Executable] mixin
      # @raise [Nanites::Errors::ValueError] if command is not an Executable
      def add(command)
        # Use duck typing to determine whether given command is an executable
        raise Nanites::Errors::ValueError, 'Given command is not an executable' unless
          command.respond_to?(:execute)

        # @commands << if command.is_a?(Class)
        #               command.new
        #             else
        #               command
        #             end
        @commands << command
      end
      alias << add

      # Execute all commands added to this composition
      # @return [Nanites::Result]
      def run(**context)
        @_context = context || {}

        result = @commands.map do |cmd|
          [cmd.executable_id, cmd.execute(@_context)]
        end.to_h

        Nanites::Result.success result
      rescue StandardError => e
        Nanites::Result.error e, 'Error running composition'
      end

      private

      # Initialize command array
      # @param [Array] commands
      def initialize_commands(commands)
        @commands = commands || []
      end
    end
  end
end
