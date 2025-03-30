Rails.application.routes.draw do
  # ヘルスチェック用のエンドポイント
  get "up" => "rails/health#show", as: :rails_health_check
  #get '/favicon.ico', to: ->(env) { [204, {}, []] }
  
  mount_devise_token_auth_for 'User', at: 'auth'

  # スレッドとコメントのルーティング
  resources :threads do
    resources :comments, only: [:index, :create, :destroy]
  end
end
