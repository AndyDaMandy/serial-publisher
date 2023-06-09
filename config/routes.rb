Rails.application.routes.draw do
  resources :tags
  #get 'users/index'
  #get 'users/show'
  #get 'users/edit'
  #get 'users/update'
  #get 'followings/create'
  #get 'followings/destroy'
  
  get 'chapters/all_chapters'
  resources :stories do
    resources :chapters
    resources :stars
    resources :bookmarks
  end
  devise_for :users
  resources :users, :only => [:index, :show, :edit, :update]

  root "chapters#all_chapters"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
