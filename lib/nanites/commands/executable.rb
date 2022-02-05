# frozen_string_literal: true

module Nanites
  module Commands
    # Nanite mixin
    module Executable

      # Instance methods code needed for any Executable
      module InstanceMethods
        attr_reader :executable_id, :payload, :result

        # Rewrite the object initializer to add required instance vars
        def initialize_executable
          @executable_id = SecureRandom.uuid.freeze
          @payload = Option.none
          @result = Result.unknown
        end

        # @abstract
        # Execute the nanite
        # @return [Nanites::Commands::Result]
        def execute(*args)
          super

          @result
        rescue StandardError => e
          Result.error e, "Error executing command with payload '#{args}'"
        end
      end

      # Class methods added to classes using this mixin
      module ClassMethods
        # Instantiate new Command object and safely run it's #execute method
        # @return [Nanites::Commands::Result]
        def execute(*args, &blk)
          cmd = new *args, &blk
          cmd.execute(*args)
        rescue StandardError => e
          Result.error e, "Error executing command with payload '#{args}'"
        end
      end

      class << self
        # Required initialization code
        def included(klazz)
          klazz.prepend InstanceMethods
          klazz.extend ClassMethods
        end
      end

      protected

      # Set the nanites output to a successful result
      # @param [Object] payload Optional payload stored within the result
      # @param [Array] messages Optional array of informational messages
      # @return [Nanites::Commands::Executable::Result]
      def success(payload, *messages)
        @result = Result.success payload, *messages
      end

      # Set the nanites output to a erroneous result
      # @param [Object] payload Optional payload stored within the result
      # @param [Array] messages Optional array of informational messages
      # @return [Nanites::Commands::Executable::Result]
      def error(payload, *messages)
        @result = Result.error payload, *messages
      end
    end
  end
end
