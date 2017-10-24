Rails.application.routes.draw do
  resources :questions do
    collection do
      get :autocomplete
    end
  end

  get 'welcome' => 'welcome#index'
  root 'welcome#index'
end
