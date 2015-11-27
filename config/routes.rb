Rails.application.routes.draw do
  get '/' => 'sites#home'
  
  resources :forms, only: [:create]

  resources :answers, only: [:create]
end
