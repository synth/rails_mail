RailsMail::Engine.routes.draw do
  resources :emails, only: [ :index, :show ]
end
