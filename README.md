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

6. **Run the tests:**

   To ensure everything is set up correctly, run the engine's tests:

   ```bash
   $ rails test
   ```
## Real-time updates

RailsMail uses Turbo, TurboStreams, and ActionCable to provide real-time updates in the ui when emails are delivered. When you send an email, the new email will be displayed in the list of emails. There may be gotchas depending on your setup and environment.

### Gotchas

- In development environment, the typical default for ActionCable (cable.yml) is to use the async adapter which is an in-memory adapter. If you try to send an email from the rails console, it will not auto-update the ui. You can change the adapter to the development adapter by running `cable.yml` to use something like the redis, postgresql adapter, or solidcable. 
- In staging environments, the same idea typically applies that you need to use a multi-process adapter like redis, postgresql, or solidcable.

## Future work / ideas

- Implement adapters to support real-time updates without ActionCable (polling or SSE)
- Implement search
- Implement introspection of application notifiers and allow manual delivery/inspection of emails
  - Need to introspect the arguments of the notifier and see if the arguments can be paired with active record models or to allow a mapping of argument type to sample data. 
  
## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
