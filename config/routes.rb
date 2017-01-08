Rails.application.routes.draw do

  root 'index#index'
  post '/action', to: 'index#action'

  get  '/auth/:provider/callback', to: 'application#login'
  get  '/logout', to: 'application#logout'

end
