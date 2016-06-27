Rails.application.routes.draw do
  devise_for :users

  # Root path
  devise_scope :user do
  	authenticated :user do
  		root 'transactions#index', as: :authenticated_root
  	end

  	unauthenticated do
  		root 'devise/sessions#new', as: :unauthenticated_root
  	end
  end

  # Transactions
  resources :transactions, only: [:show, :index, :create, :new] do
    collection do
      get 'new_top_up'
      post 'create_top_up'
    end
  end
end
