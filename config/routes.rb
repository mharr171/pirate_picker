Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :rooms, only: [:show,:create,:destroy] do
    post 'startgame'
    post 'resetgame'
    resources :buttons, only: [] do
      post 'checkbomb'
    end
    delete 'leavegame'
    resources :players, only: [:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
