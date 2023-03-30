Rails.application.routes.draw do
  get 'followings/create'
  get 'followings/destroy'
  
  resources :stories do
    resources :chapters
  end
  devise_for :users

  root "stories#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
