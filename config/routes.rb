Rails.application.routes.draw do
  get "/" => "sites#home"

  resources :forms, only: [:show, :create]

  # for typeform to post the answers back
  resources :answers, only: [:create]
end
