Rails.application.routes.draw do
  root 'static_pages#home'
  get '/home',to:'static_pages#home'
  get '/help',to:'static_pages#help'
  get '/about',to:'static_pages#about'
  get '/contact',to:'static_pages#contact'
  get '/policy',to:'static_pages#policy'
  get '/signup',to:'users#new'
  post '/signup',to:'users#create'
  get '/login',to:'sessions#new'
  post '/login',to:'sessions#create'
  delete '/logout',to:'sessions#destroy'
  get 'password_edits/edit',to:'password_edits#edit'
  get 'auth/:provider/callback', to: 'sessions#create'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :password_edits, only: [:show, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
