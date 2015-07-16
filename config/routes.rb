Rails.application.routes.draw do

  match 'auth/facebook/callback', to: 'sessions#create', via: [ :get, :post ]
  match 'auth/failure',           to: redirect('/'),     via: [ :get, :post ]

  resources :users, only: [ :show ]

end
