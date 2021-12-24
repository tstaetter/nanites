[![RSpec](https://github.com/tstaetter/nanites/actions/workflows/main.yml/badge.svg?branch=main&event=push)](https://github.com/tstaetter/nanites/actions/workflows/main.yml)

# Nanites - tiny command pattern framework for Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nanites', github: 'tstaetter/nanites', branch: 'main'
```

And then execute:

    $ bundle install

When available on rubygems.org, you can install it yourself as:

    $ gem install nanites

TODO: Push gem to rubygems when initial release is ready

## Usage

### <a name="command-section"></a>Commands

Using the commands is pretty straight forward (see specs/support for more examples).

```ruby
class MyCommand < Nanites::Actions::Command
  def execute(**params)
    # your code here
    if all_went_well
      success success_payload
    else
      error error_payload
    end
  end
end

# Be sure to only use the class method #execute, it ensures save execution
result = MyCommand.execute some_payload

puts result.option if result.success?
# => Nanites::Some @value=<success payload>
```

Result values are always wrapped in an ```Nanites::Option``` object which
either is a ```Nanites::Some``` indicating some return value is available or
```Nanites::None``` for no value.

This is done in order to not having the hassle to deal with ```nil``` values. This
approach is inspired by the Option type in [Rust](https://www.rust-lang.org/).

### Compounds

Compounds can be used to combine several commands.
A little example:

```ruby
cmd1 = SomeUsefulCommand.new payload
cmd2 = SomeAnalyticsCommand.new payload

compound = Nanites::Actions::Compound.new cmd1, cmd2

context = compound.execute
# => 'context' is a hash containing the execution results of each command with the commands ID as key
```

### Some and None

```Some``` and ```None``` are both descendants of ```Option```. Each call of ```Nanites::Actions::Command#execute``` will
return either a ```Some``` or ```None```, indicating that the call returns some value, or no value resp.

When using those values, calling ```None#value``` will always return nil. If you need to have an error raised, use ```None#value!```.

Taking the example from the [above code](#command-section), the behaviour is as follows:

```ruby
puts result.option.value
# => will return some value if result.success? is true, nil otherwise

puts result.option.value!
# => will return some value if result.success? is true, raise a Nanites::Errors::ValueError otherwise
```

## Development

`rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tstaetter/nanites.
