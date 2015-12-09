Blog::Application.routes.draw do
  root :to => "articles#index"
  resources :articles do
    member do
      post :notify_friend
    end
    resources :comments
  end
  resources :users
  resource :session
  get '/login' => "sessions#new", :as => "login"
  get '/logout' => "sessions#destroy", :as => "logout"
end
