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
  
  # 管理者用
  namespace :admin do
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show]
  end
  
  scope module: :admin do
    get 'admin' => 'homes#top', as: 'admin'
  end
  
  # 顧客用
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about', as: 'about'
    # cuntomer用のルーティング
    resource :customers, only: [:show]
    scope :customers do
      get 'information/edit' => 'customers#edit'
      patch 'information' => 'customers#update'
      get 'unsubscribe' => 'customers#unsubscribe'
      patch 'hide' => 'customers#hide'
    end
    resources :items, only: [:index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all' => 'cart_items#destroy_all'
      end
    end
    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        post 'check' => 'orders#check'
        get 'thanks' => 'orders#thanks'
      end
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
