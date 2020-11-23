Rails.application.routes.draw do
  
  root to: 'pages#home'

  devise_for :users, controllers: { registrations: 'users/registrations' }

   
  get 'accounts/:id' => 'accounts#show'
  post 'accounts/:id'=> 'accounts#course'
  get '/courses' => 'courses#index'
  patch '/courses/:id/add_students' => 'courses#add_students', :as => :add_student
  get '/courses/new' => 'courses#new'
  get '/courses/:id' => 'courses#show'
  post "/courses" => "courses#create"
  post "/courses/:id/request_join_team" => "courses#request_join_team", :as => :request_join_team

	get "/teams/new" => "teams#new"
  post "/teams" => "teams#create"
  get '/teams/:id/message_board' => 'teams#message_board'
  post "/teams/:id/message_board" => "teams#create_message", :as => :create_message
  get '/teams/:id/student_requests' => 'teams#student_requests'
  post "/teams/:id/approve_or_reject_join_team" => "teams#approve_or_reject_join_team", :as => :approve_or_reject_join_team

  get "/teams/:team_id/tasks" => "tasks#index"
  get '/teams/:team_id/tasks/:id/edit' => 'tasks#edit'
  #get "/teams/:team_id/tasks/:id" => 'tasks#show'
  post '/teams/:team_id/tasks/' => 'tasks#create'
  delete '/teams/:team_id/tasks/:id' => 'tasks#destroy'
  patch '/teams/:team_id/tasks/:id' => 'tasks#update'
  
  post "/teams/:team_id/tasks/bulk_update" => "tasks#bulk_update"

end
