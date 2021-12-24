# frozen_string_literal: true

require 'securerandom'
require_relative 'nanites/version'
require_relative 'nanites/errors'
require_relative 'nanites/option'
require_relative 'nanites/commands/result'
require_relative 'nanites/commands/command'
require_relative 'nanites/compounds/compound'
require_relative 'nanites/compounds/first_some_compound'
require_relative 'nanites/compounds/match_none_compound'
require_relative 'nanites/compounds/match_some_compound'

# Nanites implements a tiny framework for command pattern implementations
module Nanites
end
