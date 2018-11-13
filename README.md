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
                    :user_reference => "1234",
                    :review_body => "this is my review body",
                    :review_title => "my review title" ,
                    :review_score => 5,
                    :signature => "The SHA256 or HMAC signature goes here",
                    :time_stamp => "1426770722",
                    :reviewer_type => "verified_buyer"
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

For that we will need to go through Yotpo authenticaton process, provide an app_key and secret, and return to get the utoken. The utoken will allow us to make authenticated API calls.

```ruby
ak = "d3n27Sg0eP8MHmVCHfPdQzyxjhwIEeV5cBKhoggC" #remember to replace the APP_KEY with your own.
st = "adsfasdf68ads6fadsfkjbhkljhciolqewrnqwew" #remember to replace the SECRET with your own.


# retrieving the utoken - will be valid for 24 hours
response = Yotpo.get_oauth_token :app_key => ak, :secret => st
utoken = response.body.access_token

#first creating the products that are in the order, notice that the key of the product hash is the product_sku
products = {
            "BLABLA1" => {
                    :url => "http://shop.yotpo.com/products/amazing-yotpo-poster",
                    :name => "Yotpo Amazing Poster",
                    :image_url => "http://cdn.shopify.com/s/files/1/0098/1912/products/qa2_medium.png?41",
                    :description => "this is the most awesome poster in the world!",
                    :price => "100"
                }
            }

# now we will create a purchase using this the token we have received in the previous step

response = Yotpo.create_new_purchase    :app_key => ak,
                                        :utoken => utoken,
                                        :email => "trial@yotpo.com",
                                        :customer_name => "bob",
                                        :order_id => "12999",
                                        :platform => "Shopify",
                                        :order_date => "2013-05-28",
                                        :products => products,
                                        :currency_iso => "USD"

#making sure our request went through

raise Exception unless response.body.code == 200

```

We can pull all the purchases of a certain account to make sure that the previous calls has worked

```ruby

response = Yotpo.get_purchases :app_key => ak, :utoken => utoken, :since_date => "2013-05-26"

```


[register]: https://www.yotpo.com/register

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
