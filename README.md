# RailsMail
RailsMail is a Rails engine that provides a database-backed delivery method for Action Mailer, primarily intended for local development and staging environments. It captures emails sent through your Rails application and provides a web interface to view them.

RailsMail saves all outgoing emails to your database instead of actually sending them. This is particularly useful for:
- Local development to inspect emails without setting up a real mail server
- Staging environments where you want to prevent actual email delivery
- Testing email templates and layouts

![rails mail screenshot](http://github.com/synth/rails_mail/blob/main/rails-mail-demo.png)

### Features
* Implements delivery_method for ActionMailer to catch emails and store them in the database
* Real-time updates using Turbo and ActionCable
* Search functionality across email fields (subject, from, to, cc, bcc)
* Clean, responsive UI for viewing email contents
* Optional authentication support
* Trimming emails older than a specified duration or a maximum number of emails
* Ability to manually clear emails out and turn on/off that functionality based on environment (eg, so that in Staging, other stakeholders can't clear emails out, but in dev sometimes you want a clean slate)
* Dynamic time ago in words using date-fns

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


## Usage

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

3. **Configure the initializer**
   See the [Configuration](#configuration) section for more details.

4. **Visit `/rails_mail` in your browser to view all captured emails.**

### Configuration

RailsMail can be configured through an initializer:

```ruby
# config/initializers/rails_mail.rb
RailsMail.configure do |config|
  # Optional authentication callback
  # (if using Authlogic. If using Devise see the Authentication section)
  config.authentication_callback do
    user_session = UserSession.find
    raise ActionController::RoutingError.new('Not Found') unless user_session&.user&.admin?
  end

  # Delete emails older than the specified duration
  config.trim_emails_older_than = 30.days

  # Keep only the most recent N emails
  config.trim_emails_max_count = 1000

  # Control whether trimming runs synchronously (:now) or asynchronously (:later)
  config.sync_via = :later
end
```

### Configuration Options

- `authentication_callback`: A block that will be called before accessing RailsMail routes
- `trim_emails_older_than`: Accepts an ActiveSupport::Duration object (e.g., 30.days). Emails older than this duration will be deleted.
- `trim_emails_max_count`: Keeps only the N most recent emails, deleting older ones.
- `sync_via`: Controls whether the trimming job runs synchronously (:now) or asynchronously (:later)

## Authentication
Authentication is optional, but recommended and will depend on your application's authentication setup. This gem provides an `authentication_callback` that you can configure in the initializer which is helpful for Authlogic. If you are using Devise, you can simply wrap the mount point of the engine. 

### Authlogic

If you're using Authlogic, configure the authentication in the initializer:
```ruby
# config/initializers/rails_mail.rb
RailsMail.configure do |config|
    config.authentication_callback do
      user_session = UserSession.find
      # Provide a more helpful message in development
      msg = Rails.env.development? ? 'Forbidden - make sure you have the correct permission in config/initializers/rails_mail.rb' : 'Not Found'
      raise ActionController::RoutingError.new(msg) unless user_session&.user&.admin?
    end
  end
end
```

### Devise

If you're using Devise, you can simply wrap the mount point of the engine using Devise's `authenticate` route helper.

```ruby
# config/routes.rb
authenticate :user, ->(user) { user.admin? } do
    mount RailsMail::Engine => "/rails_mail"
end
```

## Real-time updates

RailsMail uses Turbo, TurboStreams, and ActionCable to provide real-time updates in the ui when emails are delivered. When you send an email, the new email will be displayed in the list of emails. There may be gotchas depending on your setup and environment.

## Gotchas

- In development environment, the typical default for ActionCable (cable.yml) is to use the async adapter which is an in-memory adapter. If you try to send an email from the rails console, it will not auto-update the ui. You can change the adapter to the development adapter by running `cable.yml` to use something like the redis, postgresql adapter, or solidcable. 
- In staging environments, the same idea typically applies that you need to use a multi-process adapter like redis, postgresql, or solidcable.

## Future work / ideas

- Implement infinite scroll rather than loading all emails at once
- Implement adapters to support real-time updates without ActionCable (polling or SSE)
- Implement attachments support
- Implement introspection of application notifiers and allow manual delivery/inspection of emails
  - Need to introspect the arguments of the notifier and see if the arguments can be paired with active record models or to allow a mapping of argument type to sample data / fixtures. 
  
## Features
- Captures all outgoing emails and stores them in your database
- Real-time updates using Turbo and ActionCable
- Search functionality across email fields (subject, from, to, cc, bcc)
- Clean, responsive UI for viewing email contents
- Optional authentication support

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

