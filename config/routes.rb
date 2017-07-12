Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pictures#index'
  resources :pictures

  get 'month/:month', to: 'month#show', as: 'month_view'
end
