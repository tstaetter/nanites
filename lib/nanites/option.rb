# frozen_string_literal: true

module Nanites
  # Is raised, when a None option is tried to be unwrapped
  class ValueError < StandardError; end

  # Generic value class which either holds an instance of [Some] or [None]
  class Option
    # Create a new Option value
    # @param [Object] value If present, it will be wrapped inside a [Some] instance, otherwise a [None] value
    #   will be returned when calling #unwrap
    def initialize(value = nil); end

    # Is a [None] value?
    def none?
      is_a? None
    end

    # Is a [Some] value?
    def some?
      is_a? Some
    end

    class << self
      # Helper returning an instance of [Some]
      def some(value)
        Some.new value
      end

      # Helper returning an instance of [None]
      def none
        None.new
      end
    end
  end

  # Generic value representing a not nil value to be used inside an Option instance
  class Some < Option
    attr_reader :value

    # Create a new value container
    # @param [Object] value an arbitrary object
    # @raise ValueError if value is nil
    def initialize(value)
      raise ValueError, "Can't create a 'Some' without value" if value.nil?

      super

      @value = value
    end
  end

  # Generic value representing a nil or empty value to be used inside an Option instance
  class None < Option; end
end
