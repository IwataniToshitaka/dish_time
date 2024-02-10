Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top', as: 'root'
  get 'about', to: 'homes#about'
  #home/aboutのURLに飛んだ時、homesコントローラのindexアクションを実行

  resources :users, only: [:new, :create, :show, :index, :edit]
  resources :airticles, only: [:new, :create, :index, :show, :update, :edit, :destroy]
  resources :airticle_genres, only: [:new, :create, :index, :show]
  resources :genres, only: [:index]
  resources :comments, only: [:new, :edit, :show]
  resources :likes, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
