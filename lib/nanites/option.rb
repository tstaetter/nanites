# frozen_string_literal: true

module Nanites
  # Generic value which either holds a value ([Some]) or not ([None])
  module Option
    class << self
      # Create a container for an unknown value
      # @param [value] value option value
      # @return [Some] if not nil value was given
      # @return [None] if nil value was given
      def option(value = nil)
        value ? some(value) : none
      end

      # Create a not nil value container
      # @param [Object] value An arbitrary value
      def some(value)
        Some.new value
      end

      # Create a nil value container
      def none
        None.new
      end
    end

    # @abstract
    # Is a Some value?
    def some?; end

    # @abstract
    # Is a None value?
    def none?; end

    # @abstract
    # Safe getter for value
    # @returns [Object]
    def value; end

    # @abstract
    # Unsafe getter for value
    # @returns [Object]
    # @raise [Nanites::Errors::ValueError]
    def value!; end
  end

  # Generic class representing a not nil value
  # :reek:MissingSafeMethod { exclude: [ value! ] }
  class Some
    include Option

    attr_reader :value

    def initialize(value)
      @value = value
    end

    # @see Option#value!
    def value!
      raise Nanites::Errors::ValueError, 'Value is nil' unless @value

      @value
    end

    # @see Option#some?
    def some?
      true
    end

    # @see Option#none?
    def none?
      false
    end
  end

  # Generic class representing a nil value
  # :reek:MissingSafeMethod { exclude: [ value! ] }
  class None
    include Option

    # @see Option#some?
    def some?
      false
    end

    # @see Option#none?
    def none?
      true
    end

    # @see Option#value!
    def value!
      raise Nanites::Errors::ValueError, "No values available in a #{self.class.name} object"
    end
  end
end
