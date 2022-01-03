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

      # Create a value container
      # @param [Object] value An arbitrary value
      # @return [Some]
      def some(value)
        Some.new value
      end

      # Create a NO value container
      # @return [None]
      def none
        None.new
      end

      # @param [nil] value
      # @return [Maybe]
      def maybe(value = nil)
        Maybe.new value
      end
    end

    # @abstract
    # Is a [Some] value?
    def some?; end

    # @abstract
    # Is a [None] value?
    def none?; end

    # @abstract
    # Is a [Maybe] value?
    def maybe?; end

    # @abstract
    # Safe getter for value
    # @returns [Object]
    def value; end

    # @abstract
    # Unsafe getter for value
    # @returns [Object]
    # @raise [Nanites::Errors::ValueError]
    def value!; end

    # @abstract
    # Does a value exist?
    # @returns [Boolean]
    def value?; end
  end

  # Generic class representing explicitly SOME value
  # :reek:MissingSafeMethod { exclude: [ value! ] }
  class Some
    include Option

    attr_reader :value

    def initialize(value)
      @value = value.freeze
    end

    # @see Option#value!
    def value!
      raise Nanites::Errors::ValueError, 'Value is nil' unless @value

      @value
    end

    # @see Option#value?
    def value?
      true
    end

    # @see Option#some?
    def some?
      true
    end

    # @see Option#none?
    def none?
      false
    end

    # @see Option#maybe?
    def maybe?
      false
    end
  end

  # Generic class representing explicitly NO value
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

    # @see Option#maybe?
    def maybe?
      false
    end

    # @see Option#value!
    def value!
      raise Nanites::Errors::ValueError, "No values available in a #{self.class.name} object"
    end

    # @see Option#value?
    def value?
      false
    end
  end

  # Generic class representing either [Some] or [None]
  class Maybe
    include Option

    def initialize(value = nil)
      @value = Option.option value
      @value&.freeze
    end

    # @see Option#some?
    def some?
      false
    end

    # @see Option#none?
    def none?
      false
    end

    # @see Option#maybe?
    def maybe?
      true
    end

    # @see Option#value
    def value
      @value.value
    end

    # @see Option#value!
    def value!
      raise Nanites::Errors::ValueError, 'No value available' if @value.none?

      @value.value
    end

    # @see Option#value?
    def value?
      @value.some?
    end
  end
end
