Rails.application.routes.draw do
  root 'posts#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'signup' => 'users#new'
  post 'signup' => 'users#create'

  resources :posts, only: [:index, :new, :create]
  resources :users, only: :index
end
