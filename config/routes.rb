Sgfpoker::Application.routes.draw do

  root :to => "static#home"

  resources :games do
    resources :comments
  end
  resources :players
  resources :locations

  get "sessions/create"
  get "sessions/destroy"
  get "results/rank"
  post "results/rank_create"
  get "static/standings"
  
  match "/rank/:game_id" => "results#rank", :as => :rank
  match "/auth/twitter/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout
  match "/standings" => "static#standings", :as => :standings
  
end