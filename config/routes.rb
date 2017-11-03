Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: [:create, :destroy]
    collection do
      get :autocomplete
    end
  end

  get 'welcome' => 'welcome#index'
  root 'welcome#index'
end
