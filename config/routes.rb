Rails.application.routes.draw do
  get 'statics/index'
  get 'statics/new'
  devise_for :users
  resources :statics
  root 'statics#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
