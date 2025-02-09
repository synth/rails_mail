module RailsMail
  class BaseController < ActionController::Base
    layout "rails_mail/application"
    helper RailsMail::TurboHelper
    include RailsMail::TurboHelper

    before_action :authenticate!

    private

    def authenticate!
      instance_eval(&RailsMail.authentication_callback) if RailsMail.authentication_callback.kind_of?(Proc)
    end
  end
end
