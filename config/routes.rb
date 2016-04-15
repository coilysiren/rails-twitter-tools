Rails.application.routes.draw do

  root 'index#index'
  post '/mute', to: 'index#mute'

  get  '/auth/:provider/callback', to: 'application#login'
  get  '/logout', to: 'application#logout'

end
