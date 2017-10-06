Rails.application.routes.draw do
  devise_for :users
  resources :books do
    resources :users
    # collection do
    #     get 'sortable'
    #   end
  end
  resources :users do
    member do
      get :confirm_email
    end
  end

  root to: 'pages#home'

  controller :pages do
    get :privacy_policy
  end
end
