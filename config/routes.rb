Rails.application.routes.draw do
  mount Split::Dashboard, at: 'split'

  resources :questions do
    resources :answers, only: [:create, :destroy]
    collection do
      get :autocomplete
      get :me
    end
  end

  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords',
    registrations: 'users/registrations', omniauth_callbacks: "users/omniauth_callbacks" }
  
  get 'welcome' => 'welcome#index'
  root 'welcome#index'
end
