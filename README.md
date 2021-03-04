# SakamichiScraper
## about me
This gem is used to scrape information from Sakamichi group's(Hinatazaka46, Sakurazaka46) blog.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sakamichi_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sakamichi_scraper

## Usage

### get title of blog

#### Hinatazaka46
```ruby
hinata = SakamichiScraper::Hinatazaka.new

# get newest title of article
hinata.get_newest_blog_title

# get recent title, member name, timestamp of article
hinata.get_recent_blog_info
```

#### Sakurazaka46
```ruby
sakura = SakamichiScraper::Sakurazaka.new

# get newest title of article
sakura.get_newest_blog_title

# get recent title, member name, timestamp of article
sakura.get_recent_blog_info
```

### get images
NOTE: Any images obtained by executing the following method will be stored in folder `img/<today(yyyymmdd)>`.
#### Hinatazaka46

#### Sakurazaka46
```ruby
# get images from newest article
sakura.get_picture_in_newest_article
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sakamichi_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SakamichiScraper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sakamichi_scraper/blob/master/CODE_OF_CONDUCT.md).
