Rails.application.routes.draw do
  devise_for :users
  get 'top', to: 'homes#top'
  get 'about', to: 'homes#about'
  #home/aboutのURLに飛んだ時、homesコントローラのindexアクションを実行

  resources :user, only: [:new, :create, :show, :index, :edit]
  resources :airticle, only: [:new, :create, :show, :index]
  resources :airticle_genre, only: [:new, :create, :index, :show]
  resources :genre, only: [:index]
  resources :comment, only: [:new, :edit, :show]
  resources :like, onlu: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
