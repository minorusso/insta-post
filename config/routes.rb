Rails.application.routes.draw do
  resources :blogs
  resources :sessions, only: %i[new create destroy]
  # newアクションに登録フォーム表示
  resources :users, only: %i[new create show]
end
