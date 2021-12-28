# frozen_string_literal: true

module Nanites
  module Compounds
    # Return the result of the first command returning [Some]
    class FirstSomeCompound < Compound
      # Execute the compound. Commands causing an exception are silently ignored
      # @param [Hash] params optional parameters which get passed on to each command
      # @return [Nanites::Some] the first value
      # @return [Nanites::None] if no command returned [Some] or any of the commands raise an error
      def execute(**params)
        execute!(**params)
      rescue StandardError => _e
        Option.none
      end

      # Execute the compound
      # @todo stick to contract and return context object instead of the result
      # @param [Hash] params optional parameters which get passed on to each command
      # @return [Nanites::Some] the first value
      # @return [Nanites::None] if no command returned [Some] or any of the commands raise an error
      # :reek:DuplicateMethodCall
      # :reek:FeatureEnvy
      def execute!(**params)
        @queue.each do |cmd|
          cmd.execute(**params)
          result = cmd.result

          return result.option if result.option.some?
        end

        Option.none
      end
    end
  end
end
