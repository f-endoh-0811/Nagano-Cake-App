Rails.application.routes.draw do
  
  #管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  
  #顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  scope module: :admin do
    get 'admin' => 'homes#top', as: 'admin'
    resources :genres, only: [:index, :edit, :new, :create, :update]
  end
  
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about', as: 'about'
    # cuntomer用のルーティング
    get 'customers' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/hide' => 'customers#hide'
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
