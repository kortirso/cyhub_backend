Rails.application.routes.draw do
  devise_for :users, skip: %i[session registration], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  localized do
    get 'omniauth/:provider' => 'users/omniauth#localized', as: :localized_omniauth
    devise_for :users, skip: :omniauth_callbacks, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

    scope path: '/admin' do
      get '/' => 'admins#index', as: :admin_panel
      resources :users, only: %i[index edit update destroy]
      resources :partners, except: %i[show]
      resources :members, except: %i[show new]
      resources :events, except: %i[show]
    end

    namespace :api do
      namespace :v1 do
        get 'users/me' => 'users#me'
        resources :partners, only: %i[index]
        resources :members, only: %i[index]
        resources :events, only: %i[index]
      end
    end

    root to: 'welcome#index'
  end
end
