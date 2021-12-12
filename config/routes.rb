Rails.application.routes.draw do
  # newアクションに登録フォーム表示
  resources :users, only: %i[new create show]
end
