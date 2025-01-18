module RailsMail
  class Engine < ::Rails::Engine
    isolate_namespace RailsMail

    initializer "rails_mail.add_delivery_method" do
      ActiveSupport.on_load :action_mailer do
        ActionMailer::Base.add_delivery_method :rails_mail, RailsMail::DeliveryMethod
      end
    end
  end
end
