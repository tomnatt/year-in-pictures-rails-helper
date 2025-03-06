Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  scope '/admin' do
    resources :users
    get 'list/users', to: 'users#list', as: 'users_list'
  end

  root to: 'pictures#index'
  resources :pictures

  get 'month/:month', to: 'month#show', as: 'month_view'
  get 'month-content-test/:month', to: 'month#test_month_content', as: 'test_month_content'
  get 'year/:year', to: 'year#show', as: 'year_view'
end
