Rails.application.routes.draw do
  
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }

   
  get 'accounts/:id' => 'accounts#show'
  
  get '/courses/new' => 'courses#new'
  get '/courses/:id' => 'courses#show'
	# get "/teams/:id/edit" => "teams#edit"
	# patch "/teams/:id" => "teams#update"
  post "/courses" => "courses#create"
  post "/courses/:id/request_join_team" => "courses#request_join_team", :as => :request_join_team

  get '/teams' => 'teams#index'
	get "/teams/new" => "teams#new"
	# get "/teams/:id/edit" => "teams#edit"
	# patch "/teams/:id" => "teams#update"
  post "/teams" => "teams#create"
	# delete "/teams/:id" => "teams#destroy"
  get '/teams/:id/message_board' => 'teams#message_board'
  post "/teams/:id/message_board" => "teams#create_message", :as => :create_message

end
