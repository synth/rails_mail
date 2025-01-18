# RailsMail
RailsMail is a Rails engine that provides a database-backed delivery method for Action Mailer, primarily intended for local development and staging environments. It captures emails sent through your Rails application and provides a web interface to view them.

## Usage
RailsMail saves all outgoing emails to your database instead of actually sending them. This is particularly useful for:
- Local development to inspect emails without setting up a real mail server
- Staging environments where you want to prevent actual email delivery
- Testing email templates and layouts

To use RailsMail in your application:

1. Configure Action Mailer to use RailsMail as the delivery method:
```ruby
# config/environments/development.rb (or staging.rb)
config.action_mailer.delivery_method = :rails_mail
```

2. Mount the engine in your routes:
```ruby
# config/routes.rb
mount RailsMail::Engine => "/rails_mail"
```

3. Visit `/rails_mail` in your browser to view all captured emails.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "rails_mail"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_mail
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
