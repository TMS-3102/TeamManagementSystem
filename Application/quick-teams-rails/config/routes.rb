Rails.application.routes.draw do
  
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :teams 
  get 'users/:id' => 'users#show'
  get '/courses/:id' => 'courses#show'
  get '/teams/:id/message_board' => 'teams#message_board'

end
