Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  devise_for :users, path: "account", controllers: {
    registrations: :account,
    sessions: :sessions,
    passwords: :passwords,
  }

  resource :setting do
    member do
      get :account
      get :password
      get :profile
      get :reward
    end
  end

  # WARRING! 请保持 User 的 routes 在所有路由的最后，以便于可以让用户名在根目录下面使用，而又不影响到其他的 routes
  # 比如 http://localhost:3000/huacnlee
  # get "users/city/:id", to: "users#city", as: "location_users"
  get "users", to: "users#index", as: "users"
  constraints(id: /[#{User::LOGIN_FORMAT}]*/) do
    resources :users, path: "", as: "users" do
      # member do
      #   get :favorites
      #   get :calendar
      # end
    end
  end
end
