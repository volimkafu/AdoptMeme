AdoptMeme::Application.routes.draw do
  resources :users, :only => [:index, :new, :create]
  resource :session, :only => [:new, :create, :destroy]
  root :to => "static_pages#root"
  namespace :api do
    resources :captions, :only => [:create, :index]
    resources :images, :only => [:index]
  end

  get "/:everythingelse", to: "static_pages#root"

end
