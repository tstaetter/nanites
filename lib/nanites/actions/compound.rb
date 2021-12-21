# frozen_string_literal: true

module Nanites
  module Actions
    # Compounds are collections of nanites, executing each contained
    # nanite, passing the result from an executed as input for the next
    # one
    class Compound
      # Create a new compound
      def initialize(nanites)
        @nanites = nanites
      end
    end
  end
end
