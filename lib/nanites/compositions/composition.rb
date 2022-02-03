# frozen_string_literal: true

module Nanites
  module Compositions
    # Composition combines several commands and uses guards to determine
    # whether a command should be executed
    class Composition
      attr_reader :commands

      def initialize(*commands, **context, &blk)
        @commands = commands || []
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
      # @param [Nanites::Commands::Executable] command Either a command class or object
      # @raise [Nanites::Errors::ValueError] if command is not an Executable
      def add(command, **guard)
        # Use duck typing to determine whether given command is an executable
        raise Nanites::Errors::ValueError, 'Given command is not an executable' unless
          command.respond_to?(:execute)

        @commands << [command, parse_guard(**guard)]
      end
      alias << add

      # Execute all commands added to this composition
      # @return [Nanites::Result]
      def run
        result = @commands.map do |pair|
          guard = pair.first
          cmd = pair.last

          [cmd.id, cmd.execute(@_context)] if guard.call(@_context)
        end.to_h

        Nanites::Result.success result
      rescue StandardError => e
        Nanites::Result.error e, 'Error running composition'
      end

      private

      # Helper parsing execution guards
      # @return [Proc | nil]
      def parse_guard(**params)
        params.each_pair do |key, guard|
          return guard if key.eql?(:if)
        end
      end
    end
  end
end
