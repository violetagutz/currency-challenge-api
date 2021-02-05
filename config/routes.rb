Rails.application.routes.draw do
  post 'card/create', to: 'cards#create'
  post 'charge/create', to: 'transactions#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
