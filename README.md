[![RSpec](https://github.com/tstaetter/nanites/actions/workflows/main.yml/badge.svg?branch=main&event=push)](https://github.com/tstaetter/nanites/actions/workflows/main.yml)

# Nanites - tiny command pattern framework for Ruby

## TODOs

- Push gem to rubygems when first major release is ready
- Fix reek warning in executable.rb:26
- Implement #deconstruct, #deconstruct_keys to be able to use pattern matching

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nanites', github: 'tstaetter/nanites', branch: '1.0.0-rc'
```

And then execute:

    $ bundle install

When available on rubygems.org, you can install it yourself as:

    $ gem install nanites

## Usage

### <a name="command-section"></a>Commands

Using the commands is pretty straight forward (see specs/support for more examples).

```ruby
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

# Be sure to only use the class method #execute, it ensures save execution
result = SimpleCommand.execute some_payload

puts result.option if result.success?
# => Nanites::Some @value=<success payload>
```

Result values are always wrapped in an ```Nanites::Option``` object which
either is a ```Nanites::Some``` indicating some return value is available or
```Nanites::None``` for no value.

This is done in order to not having the hassle to deal with ```nil``` values. This
approach is inspired by the Option type in [Rust](https://www.rust-lang.org/).

The magic happens here in the line ```@filter = ->(result) { result.option.some? }``` defining lambda checking the result.
The filter is applied within the parent class ```execute``` method, getting passed each command result.

### Some, None and Maybe

```Some```, ```None``` and ```Maybe``` are all classes using the mixin ```Option```. Each call of 
```Nanites::Commands::Command#execute``` will return one of those three options, indicating that the call returns some value (```Some```), 
no value (```None```) or ```Maybe```. The latter one typically indicates something weired happened.

When using those values, calling ```None#value``` will always return nil. If you need to have an error raised, use ```None#value!```.

Taking the example from the [above code](#command-section), the behaviour is as follows:

```ruby
puts result.option.value
# => will return some value if result.success? is true, nil otherwise

puts result.option.value!
# => will return some value if result.success? is true, raise a Nanites::Errors::ValueError otherwise
```

Freshly initialized and yet executed commands will always return a ```Maybe```.
## Development

`rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tstaetter/nanites.
