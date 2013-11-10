AdoptMeme::Application.routes.draw do
  resources :users, :only => [:index, :new, :create]
  resource :session, :only => [:new, :create, :destroy]
  root :to => "images#index"
  get '/captions', to: "captions#index"
  get '/:captionid', to: "captions#show"
  get '/:imageid/new', to: "captions#new"
end
