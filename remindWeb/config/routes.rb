<<<<<<< HEAD
Rails.application.routes.draw do																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																		Rails.application.routes.draw do
  get 'sessions/new'

  root                   'welcome#index'
=======
Rails.application.routes.draw do
  root                  'welcome#index'
>>>>>>> new_routes.rb
  get        'signup' => 'users#new'
  get        'login'  => 'sessions#new'
  post       'login'  => 'sessions#create'
  delete     'logout' => 'sessions#destroy'
  resources :users
<<<<<<< HEAD
end
end

=======
end
>>>>>>> new_routes.rb
