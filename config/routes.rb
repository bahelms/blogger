BlogApp::Application.routes.draw do
	root to: 'static_pages#home'
  resources :users, except: [:index]
  resources :sessions, only: [:new, :create, :destroy]
  get '/signup',     to: 'users#new'
  get '/signin',     to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
end
