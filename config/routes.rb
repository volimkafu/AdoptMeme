AdoptMeme::Application.routes.draw do
  resources :users, :only => [:index, :new, :create]
  resource :session, :only => [:new, :create, :destroy]
  root :to => "images#index"
  get '/:captionid', to: "captions#show"
  resources :captions, :only => [:create, :index]
  get '/:imageid/new', to: "captions#new"
end
