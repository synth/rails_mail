RailsMail.configure do |config|
  # Authentication setup
  # if left blank, authentication is skipped
  # config.authentication_callback do
    # Example implementation for Authlogic:
    # user_session = UserSession.find
    # msg = Rails.env.development? ? 'Forbidden - make sure you have the correct permission in config/initializers/rails_mail.rb' : 'Not Found'
    # raise ActionController::RoutingError.new(msg) unless user_session&.user&.admin?
  # end
end
