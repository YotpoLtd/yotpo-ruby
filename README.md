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

Now lets make some public calls to our api. Public calls only require you to use a valid app_key. 

Creating your first review using the API

```ruby
ak = "MY_APP_KEY"

Yotpo.create_review :app_key => ak, 
                    :product_id => "BLABLA", 
                    :shop_domain => "omri.co", 
                    :product_title => "pt", 
                    :product_description => "pd", 
                    :product_url => "http://google.com/?q=myproducturl", 
                    :product_image_url => "https://www.google.com/images/srpr/logo4w.png", 
                    :user_display_name => "MOSHE", 
                    :user_email => 'haim@yotpo.com', 
                    :review_body => "this is my review body", 
                    :review_title => "my review title" , 
                    :review_score => 5
```

and now lets retrieve all the reviews of our product BLABLA

```ruby

response = Yotpo.get_product_reviews :app_key => ak, :product_id => "BLABLA"

my_review = response.body.reviews.first

my_review.title
# => my review title

my_review.score
# => 5

```

getting the bottom line of product BLABLA

```ruby
response = Yotpo.get_product_bottom_line :app_key => ak, :product_id => "BLABLA"

response.body.bottomline.total_reviews
# => 1 

response.body.bottomline.average_score
# => 5.0
```

Now lets try something a little bit more complicated. Lets try to create a purchase. 



[register]: https://www.yotpo.com/register

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
