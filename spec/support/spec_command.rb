# frozen_string_literal: true

# Sample command used for the specs
# Assumes no payload is given
class SpecCommand < Nanites::Actions::Command
  def execute(**params)
    if params.empty?
      error params, 'No parameters defined'
    else
      messages = params.map { |k, v| "#{k} => #{v}" }
      success params, *messages
    end

    super
  end
end

class PayloadSpecCommand < Nanites::Actions::Command
  def execute(**params)
    success @payload, "Got a #{@payload.class.name} object as payload"
    error nil, 'Got nil as payload' unless @payload

    super
  end
end

class AlwaysErrorCommand < Nanites::Actions::Command
  def execute(**params)
    raise StandardError, 'Will always be raised'
  end
end
