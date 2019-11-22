Rails.application.routes.draw do
  
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :teams 
  get 'accounts/:id' => 'accounts#show'
  get '/courses/:id' => 'courses#show'
  get '/teams/:id/message_board' => 'teams#message_board'

end
