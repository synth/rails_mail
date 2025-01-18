# RailsMail
RailsMail is a Rails engine that provides a database-backed delivery method for Action Mailer, primarily intended for local development and staging environments. It captures emails sent through your Rails application and provides a web interface to view them.

## Usage
RailsMail saves all outgoing emails to your database instead of actually sending them. This is particularly useful for:
- Local development to inspect emails without setting up a real mail server
- Staging environments where you want to prevent actual email delivery
- Testing email templates and layouts

To use RailsMail in your application:

1. **Configure Action Mailer to use RailsMail as the delivery method:**

   Add the following configuration to your `config/environments/development.rb` (or `staging.rb`):

   ```ruby
   config.action_mailer.delivery_method = :rails_mail
   ```

2. **Mount the engine in your routes:**

   Add the following line to your `config/routes.rb`:

   ```ruby
   mount RailsMail::Engine => "/rails_mail"
   ```

3. **Visit `/rails_mail` in your browser to view all captured emails.**

## Installation

To install RailsMail, follow these steps:

1. **Add the gem to your application's Gemfile:**

   ```ruby
   gem "rails_mail"
   ```

2. **Run `bundle install` to install the gem:**

   ```bash
   $ bundle install
   ```

3. **Generate the necessary database migration:**

   Run the following command to create the migration for storing emails:

   ```bash
   $ rake rails_mail:install:migrations
   ```

4. **Run the migration:**

   Apply the migration to your database:

   ```bash
   $ rails db:migrate
   ```

5. **Start your Rails server and access the RailsMail interface:**

   Visit `http://localhost:3000/rails_mail` to view captured emails.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
