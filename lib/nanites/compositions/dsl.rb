# frozen_string_literal: true

module Nanites
  module Compositions
    # Convenient DSL for handling compositions
    module DSL
      def compose(**context, &blk)
        Composition.new([], context, blk)
      end
    end
  end

  extend Nanites::Compositions::DSL
end
