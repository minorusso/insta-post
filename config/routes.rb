Rails.application.routes.draw do
  root to: 'users#new'
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: %i[new create destroy]
  resources :users
  resources :favorites

  mount LetterOpenerWeb::Engine, at: 'inbox' if Rails.env.development?
end
