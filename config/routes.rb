Rails.application.routes.draw do

  match 'auth/facebook/callback', to: 'api/v1/sessions#create', via: [ :get, :post ]
  match 'auth/failure',           to: redirect('/'),            via: [ :get, :post ]

  scope module: 'api' do
    namespace :v1 do

      resources :users, only: [ :show ]
      resources :lobbies, only: [ :create, :show ] do
        resources :games, only: [ :show, :update, :create ]
      end
      resources :memberships, only: [ :create ]

    end
  end

end
