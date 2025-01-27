# rubocop:disable Layout/CommentIndentation

RailsMail.configure do |config|
  # Authentication setup
  # if left blank, authentication is skipped
  # config.authentication_callback do
    # Example implementation for Authlogic:
    # user_session = UserSession.find
    # msg = Rails.env.development? ? 'Forbidden - make sure you have the correct permission in config/initializers/rails_mail.rb' : 'Not Found'
    # raise ActionController::RoutingError.new(msg) unless user_session&.user&.admin?
  # end

  config.show_clear_button do
    # show clear button in development
    # and prefer to trim in non-development environments
    # to prevent accidental deletion of emails
    Rails.env.development?
  end

  config.trim_emails_older_than = 30.days
  config.trim_emails_max_count = 1000
  config.sync_via = :later
end
