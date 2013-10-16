AdoptMeme::Application.routes.draw do
  resources :images, :users
  resource :session
end
