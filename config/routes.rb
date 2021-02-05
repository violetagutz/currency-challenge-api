Rails.application.routes.draw do
  post 'card/create', to: 'cards#create'
  post 'charge/create', to: 'transactions#create'
  get 'get_card', to: 'cards#get_card_if_exists'
  get 'card/available_balance', to: 'cards#available_balance'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
