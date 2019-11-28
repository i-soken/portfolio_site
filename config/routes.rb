Rails.application.routes.draw do


 

 

  root 'static_pages#home'
  get '/top' , to: 'static_pages#top'
  get '/home' ,to:'static_pages#home'
  get '/about' ,to:'static_pages#about'
  get '/signup', to:'users#new'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/posts', to: 'posts#index'
  
  
  resources :users do
    member do
      get :following,:followers
    end
  end
  resources :users
  resources :posts,only: [:index,:show,:create,:destroy]
  resources :relationships,only: [:create,:destroy]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
end
