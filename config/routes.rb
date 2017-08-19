Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users do
    member do
      get :confirm_email
    end
  end

  root to: 'pages#home'
end
