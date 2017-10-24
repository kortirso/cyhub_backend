Rails.application.routes.draw do
    devise_for :users, skip: %i[session registration], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
    localized do
        get 'omniauth/:provider' => 'users/omniauth#localized', as: :localized_omniauth
        devise_for :users, skip: :omniauth_callbacks, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

        scope path: '/admin' do
            get '/' => 'admins#index', as: :admin_panel
            resources :users, only: %i[index edit update destroy]
        end

        namespace :api do
            namespace :v1 do
                get 'users/me' => 'users#me'
            end
        end

        root to: 'welcome#index'
    end

    match '*path', to: 'application#catch_404', via: :all
end
