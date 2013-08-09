BlogApp::Application.routes.draw do
	root 'static_pages#home'
  resources :users, except: [:index]
  resources :sessions, only: [:new, :create, :destroy]
  resources :articles
  get '/signup',     to: 'users#new'
  get '/signin',     to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
end
