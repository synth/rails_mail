desc "Copy over the migration and initializer RailsMail"
namespace :rails_mail do
  task :install do
    Rails::Command.invoke :generate, [ "rails_mail:install" ]
  end

  # task :update do
  #   Rails::Command.invoke :generate, [ "rails_mail:update" ]
  # end
end
