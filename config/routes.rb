RailsMail::Engine.routes.draw do
  scope :frontend, controller: :frontends do
    get "modules/:name", action: :module, as: :frontend_module, constraints: { format: "js" }
    get "static/:name", action: :static, as: :frontend_static, constraints: { format: %w[css js] }
  end

  resources :emails, only: [ :index, :show ]
  root to: "emails#index"
end
