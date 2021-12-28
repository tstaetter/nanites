# frozen_string_literal: true

module Nanites
  module Compositions
    # Execute command if a key/value pair is present in the composition context
    class HasValueInContextGuard < ExecutionGuard
      def initialize(context, contract = ValueInContextContract)
        super
      end

      # Pass parameters :name, :value and an optional :condition (which will be applied on the value) to get a
      #   positive result
      # @see [super#execute?]
      # @return [TrueClass] if all conditions apply
      # @return [FalseClass] if conditions don't apply or an error happens
      def execute?(**params)
        # calling #super performs validation
        super

        pair_equals = @context[params[:name]].eql?(params[:value])
        condition = params[:condition]

        condition ? condition.call(value) && pair_equals : pair_equals
      end
    end
  end
end
