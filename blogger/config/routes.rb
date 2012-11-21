Blogger::Application.routes.draw do
  resources :authors

  root :to => 'articles#index'
  get "tags/index"

  get "tags/show"

  resources :articles do
         get 'top_articles', :on => :collection
     end

  resources :articles
  resources :comments
  resources :tags
  resources :author_sessions


  match 'login' => 'author_sessions#new', :as => :login
  match 'logout' => 'author_sessions#destroy', :as =>:logout
  match 'articles/top_articles/' => 'articles#index'

end
