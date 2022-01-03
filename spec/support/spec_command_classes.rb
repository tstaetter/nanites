# frozen_string_literal: true

# Sample command used for the specs
# Assumes no payload is given
class SimpleCommand
  include Nanites::Commands::Executable

  attr_reader :test_name

  def initialize(my_name)
    @test_name = my_name
  end

  # @see [Nanites::Commands::Executable#execute]
  def execute(*_args)
    success 'I am the success payload', 'Executed successfully'
  end
end

class ErrorCommand
  include Nanites::Commands::Executable

  # @see [Nanites::Commands::Executable#execute]
  def execute(*args)
    raise StandardError if args.empty?

    error args if args.length.eql?(1)
    success args if args.length.eql?(2)
  end
end