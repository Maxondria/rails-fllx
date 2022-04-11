Rails.application.routes.draw do
  root 'movies#index'

  resources :movies do
    resources :reviews
    resources :favorites, only: %i[create destroy]
  end

  get 'movies/filter/:filter' => 'movies#index', :as => :filtered_movies

  resources :users
  get 'signup' => 'users#new'

  resource :session, only: %i[new create destroy]
  get 'signin' => 'sessions#new'

  resources :genres
end
