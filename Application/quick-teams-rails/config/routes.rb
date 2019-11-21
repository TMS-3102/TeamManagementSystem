Rails.application.routes.draw do
  
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :teams 
  get '/teams/:id/message_board', to: 'teams#message_board'

end
