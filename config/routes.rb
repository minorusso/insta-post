Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: %i[new create destroy]
  # newアクションに登録フォーム表示
  resources :users
  resources :favorites
end
