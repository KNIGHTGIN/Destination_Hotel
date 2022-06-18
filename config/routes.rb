Rails.application.routes.draw do
  #管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  #会員
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  root to: "public/homes#top"
  get "about" => 'public/homes#about'
  devise_scope :user do
    post '/users/guest_session', to: 'public/sessions#new_guest'
  end


  scope module: :public do
    get "users/my_page" => "users#show"
    get "users/unsubscribe" => "users#unsubscribe"
    get "users/my_page/edit" => "users#edit"
    patch "users/withdraw" => "users#withdraw"
    patch "users/my_page" => "users#update"
      resources :follows, only:[:create, :destroy]
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :likes, only:[:create, :destroy]
      resources :follows, only:[:create, :destroy]
      resource :comments, only:[:create]
    end
    resources :comments, only:[:destroy]
  end

  namespace :admin do
    resources :posts, only:[:index, :new, :create, :show, :edit, :update]
    resources :tags, only:[:index, :create, :edit, :update]
    resources :users, only:[:index, :show, :edit, :update]
  end

# タグの検索で使用する
  get "search_tag" => "public/posts#search_tag"


end
