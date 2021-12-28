# frozen_string_literal: true

module Nanites
  module ValidationContracts
    # Validation contract used for [Nanites::Compositions::HasValueInContextGuard]
    class ValueInContextContract < NanitesContract
      params do
        required(:name).value(:string)
        required(:value).filled
        optional(:condition)
      end

      rule :name do
        key.failure('property "name" must be present') if value.empty?
      end

      rule :value do
        key.failure('property "value" must be present') if value.nil? || value&.empty?
      end

      rule :condition do
        key.failure('property "condition must respond to #call"') unless value.nil? && !value.respond_to?(:call)
      end
    end
  end
end
