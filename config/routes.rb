Rails.application.routes.draw do
  #管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  #会員
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/users/passwords'
}

  root to: "public/homes#top"
  get "about" => 'public/homes#about'
  devise_scope :user do
    post '/users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  scope module: :public do
    get "users/my_page" => "users#my_page"
    get "users/unsubscribe" => "users#unsubscribe"
    get "users/my_page/edit" => "users#edit"
    patch "users/withdraw" => "users#withdraw"
    patch "users/my_page" => "users#update"
    resources :users, only:[:show] do
      resources :follows, only:[:create, :destroy]
      get 'followings' => 'follows#following', as: 'followings'
      get 'followers' => 'follows#followers', as: 'followers'
    end
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :likes, only:[:create, :destroy]
      resource :comments, only:[:create]
    end
    resources :comments, only:[:destroy]
  end

  namespace :admin do
    root to: 'posts#index'
    resources :posts, only:[:index, :show, :edit, :update, :destroy]
    resources :tags, only:[:index, :destroy]
    resources :users, only:[:index, :show, :edit, :update]
  end

# タグの検索で使用する
  get "search_tag" => "public/posts#search_tag"
  get "search" => "public/searches#search_result"


end
