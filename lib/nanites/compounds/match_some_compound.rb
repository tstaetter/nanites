# frozen_string_literal: true

module Nanites
  module Compounds
    # Filter compound results to only [Some] values
    # :reek:InstanceVariableAssumption { enabled: false }
    class MatchSomeCompound < Compound
      def initialize(*nanites, shall_fail: false)
        super

        @filter = ->(result) { result.option.some? }
      end
    end
  end
end
