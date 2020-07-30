Rails.application.routes.draw do

  root to: 'home#index'

  get 'home/index'

  get 'styles/atoms'

  get 'styles/molecules'

  get 'styles/organisms'


  get 'account/ideas'

  get 'login', to: 'session#new'

  get 'signup', to: 'users#new'

  resources :sessions, only: [:new, :create, :destroy]

  resources :users do
    resources :goals
  end

  resources :ideas do
    resources :comments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
