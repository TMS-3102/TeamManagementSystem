Rails.application.routes.draw do
  
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }

   
  get 'accounts/:id' => 'accounts#show'
  get '/courses' => 'courses#index'
  patch '/courses/:id/add_students' => 'courses#add_students', :as => :add_student
  get '/courses' => 'courses#index'
  get '/courses/new' => 'courses#new'
  post 'accounts/:id'=> 'accounts#course'
  get '/courses/:id' => 'courses#show'
  post "/courses" => "courses#create"
  post "/courses/:id/request_join_team" => "courses#request_join_team", :as => :request_join_team

  # get '/teams' => 'teams#index'
	get "/teams/new" => "teams#new"
	# get "/teams/:id/edit" => "teams#edit"
	# patch "/teams/:id" => "teams#update"
  post "/teams" => "teams#create"
	# delete "/teams/:id" => "teams#destroy"
  get '/teams/:id/message_board' => 'teams#message_board'
  post "/teams/:id/message_board" => "teams#create_message", :as => :create_message
  get '/teams/:id/student_requests' => 'teams#student_requests'
  post "/teams/:id/approve_or_reject_join_team" => "teams#approve_or_reject_join_team", :as => :approve_or_reject_join_team

end
