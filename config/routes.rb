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

  scope module: :public do
    get "users/my_page" => "users#show"
    get "users/unsubscribe" => "users#unsubscribe"
    get "users/my_page/edit" => "users#edit"
    patch "users/withdraw" => "users#withdraw"
    patch "users/my_page" => "users#update"
      resources :follows, only:[:create, :destroy]
    resources :posts, only:[:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :likes, only:[:create, :destroy]
      resources :comments, only:[:create, :destroy]
      resources :follows, only:[:create, :destroy]
    end
  end

  namespace :admin do
    resources :posts, only:[:index, :new, :create, :show, :edit, :update]
    resources :tags, only:[:index, :create, :edit, :update]
    resources :users, only:[:index, :show, :edit, :update]
  end

end
