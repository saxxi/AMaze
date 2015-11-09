Rails.application.routes.draw do

  root 'games#index'
  resource :games, only: [:index, :create]

end
