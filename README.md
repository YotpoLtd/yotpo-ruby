# Yotpo

A Ruby interface to the YOTPO API

[gem]: http://rubygems.org/gems/yotpo
[travis]: http://travis-ci.org/YotpoLtd/yotpo-ruby
[gemnasium]: https://gemnasium.com/YotpoLtd/yotpo-ruby
[codeclimate]: https://codeclimate.com/github/YotpoLtd/yotpo-ruby
[coveralls]: https://coveralls.io/r/YotpoLtd/yotpo-ruby

[![Gem Version](https://badge.fury.io/rb/yotpo.png)][gem]
[![Build Status](https://secure.travis-ci.org/YotpoLtd/yotpo-ruby.png?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/YotpoLtd/yotpo-ruby.png?travis)][gemnasium]
[![Code Climate](https://codeclimate.com/github/YotpoLtd/yotpo-ruby.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/YotpoLtd/yotpo-ruby/badge.png?branch=master)][coveralls]

## Installation

Add this line to your application's Gemfile:

    gem 'yotpo'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install yotpo

## Usage

First [register your application with Yotpo][register]
Then copy and past the app_key and secret
```ruby
Yotpo.configure do |config|
  config.app_key = APP_KEY
  config.secret = SECRET
end
```
That is it you are ready

[register]: https://www.yotpo.com/register

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
