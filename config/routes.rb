Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  get '/terms', to: 'static_pages#terms'
  get '/privacy', to: 'static_pages#privacy'

  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }

  resources :users, only: [:show, :edit, :update]

  root 'regions#index'

  resources :regions, only: [:index], shallow: true do
    resources :prefectures, only: [:show]
  end

  resources :place_search, only: [:index] do
    collection do
      get :search
    end
  end

  resources :off_road_circuits, only: [:show, :new, :create, :edit, :update, :destroy]

  resource :inquiry, only: [:new, :create], path_names: { new: '' } do
    collection do
      post :confirm
    end
  end

  namespace :api, { format: 'json' } do
    resources :users, only: [:index] do
      resources :favorite_courses, only: [:index, :create, :destroy]
      resources :practice_recodes, only: [:index, :show, :create, :edit, :update, :destroy]
    end

    resources :regions, only: [:index]

    resources :off_road_circuits, only: [:index]

    resources :plans, only: [:index, :create, :destroy]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
