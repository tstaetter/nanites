# frozen_string_literal: true

# Sample command used for the specs
# Assumes no payload is given
class SpecCommand < Nanites::Commands::Command
  def execute(**params)
    if params.empty?
      error params, 'No parameters defined'
    else
      messages = params.map { |k, v| "#{k} => #{v}" }
      success params, *messages
    end
  end
end

class PayloadSpecCommand < Nanites::Commands::Command
  def execute(**params)
    success @payload, "Got a #{@payload.class.name} object as payload"
    error nil, 'Got nil as payload' unless @payload
  end
end

class AlwaysErrorCommand < Nanites::Commands::Command
  def execute(**params)
    raise StandardError, 'Will always be raised'
  end
end

class NoneCommand  < Nanites::Commands::Command
  def execute(**params)
    success nil, 'Payload will always be nil'
  end
end

class SomeCommand  < Nanites::Commands::Command
  def execute(**params)
    success 'foo', 'Payload will always be something'
  end
end