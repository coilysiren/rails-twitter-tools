Rails.application.routes.draw do

  root 'index#index'

  get '/auth/:provider/callback', to: 'application#login'
  get '/logout' => 'application#logout'

end
