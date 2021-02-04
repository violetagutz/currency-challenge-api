Rails.application.routes.draw do
  post 'cards/create', to: 'cards#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
