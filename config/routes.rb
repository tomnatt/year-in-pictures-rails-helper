Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  scope '/admin' do
    resources :users
  end

  root to: 'pictures#index'
  resources :pictures

  get 'month/:month', to: 'month#show', as: 'month_view'
end
