Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top', as: 'root'
  get 'about', to: 'homes#about'
  #home/aboutのURLに飛んだ時、homesコントローラのindexアクションを実行

  resources :users, only: [:new, :create, :show, :index, :edit, :update]
  resources :articles, only: [:new, :create, :index, :show, :update, :edit, :destroy]do
    resource :likes, only: [:index, :create, :destroy]
  end
  resources :likes, only: [:index]
  resources :genres, only: [:index, :create, :edit, :update]
  resources :comments, only: [:new, :edit, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :genres, only: [:index, :create, :edit, :update]

end
