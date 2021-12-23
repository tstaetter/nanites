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

Using the framework is pretty straight forward (see specs for more examples).

```ruby
class MyCommand < Nanites::Actions::Command
  # Be sure to return the @result in any case
  def execute(**params)
    # your code here
    if all_went_well
      success success_payload
    else
      error error_payload
    end
  rescue
    super
  end
end

result = MyCommand.execute some_payload

puts result.value if result.success?
# => Nanites::Some @value=<success payload>
```

Result values are always wrapped in an ```Nanites::Option``` object which
either is a ```Nanites::Some``` indicating some return value is available or
```Nanites::None``` for no value.

This is done in order to not having the hazzle to deal with ```nil``` values. This
approach is inspired by the Option type in [Rust](https://www.rust-lang.org/).

## TODOs for the first release

- Harmonize Command#success and Command#error
- Allow command execution w/o event but only params
- Implement fault tolerant compound


## Development

`rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tstaetter/nanites.
