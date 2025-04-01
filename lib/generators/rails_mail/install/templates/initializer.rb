# rubocop:disable Layout/CommentIndentation

Rails.configuration.to_prepare do
  RailsMail.configure do |config|
    # Authentication setup
    # if left blank, authentication is skipped
    # config.authenticate do
      # Example implementation for Authlogic:
      # user_session = UserSession.find
      # msg = Rails.env.development? ? 'Forbidden - make sure you have the correct permission in config/initializers/rails_mail.rb' : 'Not Found'
      # raise ActionController::RoutingError.new(msg) unless user_session&.user&.admin?
    # end

    config.show_clear_all_button do
      # show clear button in development
      # and prefer to trim in non-development environments
      # to prevent accidental deletion of emails
      Rails.env.development?
    end

    config.trim_emails_older_than = 30.days
    config.trim_emails_max_count = 1000

    # Configure how trim jobs are enqueued
    # You can use perform_now for immediate execution (default):
    # config.enqueue_trim_job = ->(email) { RailsMail::TrimEmailsJob.perform_now }

    # Or create a custom job class:
    # class CustomTrimEmailsJob < RailsMail::TrimEmailsJob
    #   def perform
    #     Rails.logger.debug "CustomTrimEmailsJob#perform"
    #     super
    #   end
    # end

    # config.enqueue_trim_job = ->(email) { CustomTrimEmailsJob.perform_later }
  end
end
