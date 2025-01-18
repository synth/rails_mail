module RailsMail
  class ApplicationController < ActionController::Base
    layout "rails_mail/application"
    helper TurboHelper if defined?(TurboHelper)
  end
end
