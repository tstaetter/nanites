# frozen_string_literal: true

module Nanites
  module Compounds
    # Filter compound results to only [None] values
    # :reek:InstanceVariableAssumption { enabled: false }
    class MatchNoneCompound < Compound
      def initialize(*nanites, shall_fail: false)
        super

        @filter = ->(result) { result.option.none? }
      end
    end
  end
end
