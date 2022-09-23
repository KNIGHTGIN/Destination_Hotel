Rails.application.routes.draw do
  #管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  #ユーザー
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/users/passwords'
}

  root to: "public/homes#top" #topページ
  get "about" => 'public/homes#about' #aboutページ
  devise_scope :user do
    post '/users/guest_sign_in', to: 'public/sessions#guest_sign_in' #ゲストログイン機能
  end


  scope module: :public do #ユーザー機能
    get "users/my_page" => "users#my_page" #ユーザーマイページ
    get "users/unsubscribe" => "users#unsubscribe" #ユーザーの退会機能
    get "users/my_page/edit" => "users#edit" #ユーザーマイページの編集機能
    patch "users/withdraw" => "users#withdraw"
    patch "users/my_page" => "users#update"
    resources :users, only:[:show] do
      resources :follows, only:[:create, :destroy] #フォロー機能
      get 'followings' => 'follows#following', as: 'followings'#フォロー
      get 'followers' => 'follows#followers', as: 'followers'#フォロワー
      member do #一覧表示
        get 'likes'
        get 'hotels'
        get 'comments'
      end
    end
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :likes, only:[:create, :destroy, :index] #いいね機能
      resource :comments, only:[:create] #コメント機能
    end
    resources :comments, only:[:destroy]
    #googlamap
    resources :maps, only: [:index]
  end

  namespace :admin do #管理者ページ
    root to: 'posts#index'
    resources :posts, only:[:index, :show, :edit, :update, :destroy]
    resources :tags, only:[:index, :edit]
    resources :users, only:[:index, :show, :edit, :update]
      get "tags/destroy_all" => "tags/destroy_all" # タグの削除、管理
  end



# タグの検索
  get "search_tag" => "public/posts#search_tag" #タグからの検索機能
  get "search" => "public/searches#search_result" #検索結果表示機能


end
