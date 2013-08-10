BlogApp::Application.routes.draw do
	root 'static_pages#home'
  resources :users, except: [:index], shallow: true do
    resources :articles
  end
  resources :sessions, only: [:new, :create, :destroy]
  
  get '/signup',     to: 'users#new'
  get '/signin',     to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
end
