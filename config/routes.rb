Rails.application.routes.draw do
  resources :transactions, only: [:index]
end
