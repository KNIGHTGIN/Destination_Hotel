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
    resources :users, only:[:show, :edit, :update, :unsubscribe, :withhdraw] do
      resources :follows, only:[:create, :destroy]
    end
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
