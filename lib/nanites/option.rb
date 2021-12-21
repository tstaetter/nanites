# frozen_string_literal: true

module Nanites
  # Generic value class which either holds an instance of [Some] or [None]
  class Option
    # Create a new Option value
    def initialize(_ = nil); end

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
    # Create a new value container
    # @param [Object] value an arbitrary object
    def initialize(value)
      super
      @value = value
    end

    # Getter for encapsulated value object
    # @raise [Nanites::Errors::ValueError] if value is nil
    def value
      raise Nanites::Errors::ValueError, 'Value is nil' unless @value

      @value
    end
  end

  # Generic value representing a nil or empty value to be used inside an Option instance
  class None < Option
    # Convenience method raising a ValueError if called
    # @raise [Nanites::Errors::ValueError]
    def value
      raise Nanites::Errors::ValueError, "No values available in a #{self.class.name} object"
    end
  end
end
