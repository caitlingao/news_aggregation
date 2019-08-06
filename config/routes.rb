Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  match '/uploads/:path(![large|lg|md|sm|xs])', to: 'home#uploads', via: :get, constraints: {
    path: /[\w\d\.\/\-]+/i
  }

  devise_for :users, path: 'account', controllers: {
    sessions: :sessions,
    passwords: :passwords,
  }

  resource :setting, only: [:show, :update] do
    get :password, on: :member
  end

  resources :sections, only: :show
  resources :topics, only: :show
  resources :photos

  get 'markdown', to: 'home#markdown', as: 'markdown'

  namespace :admin do
    root to: 'home#index', as: 'root'
    resources :site_configs
    resources :topics do
      member do
        post :undestroy
        post :action
      end
      post :preview, on: :collection
    end
    resources :nodes
    resources :sections
    resources :users, constraints: { id: /[#{User::LOGIN_FORMAT}]*/ } do
      member do
        delete :clean
      end
    end
    resources :photos
  end

  # WARRING! 请保持 User 的 routes 在所有路由的最后，以便于可以让用户名在根目录下面使用，而又不影响到其他的 routes
  # 比如 http://localhost:3000/huacnlee
  # get "users/city/:id", to: "users#city", as: "location_users"
  get "users", to: "users#index", as: "users"
  constraints(id: /[#{User::LOGIN_FORMAT}]*/) do
    resources :users, path: "", as: "users"
  end

  match "*path", to: "home#error_404", via: :all
end
