# Nanites: tiny command pattern framework for Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nanites'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install nanites

## Usage

## TODO

- Harmonize Command#success! and Command#error!
- Allow command execution w/o event but only params
- Implement fault tolerant compound
- Implement transactional compound
- Write usage instructions


## Development

`rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tstaetter/nanites.
