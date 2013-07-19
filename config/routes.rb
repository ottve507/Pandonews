Auth::Application.routes.draw do
  
  resources :suggestions do
    resources :comments
  end

  match "/feeds/add_feed", to: "feeds#add_feed", :as => "add_feed"
  resources :feeds do
    resources :comments
  end

  match "/feeds/new", to: "feeds#new", :as => "new"
  get "home/index"
  get "relationships/index"

  get "comments/index"
  get "comments/show"
  get "comments/create"

  root to: "home#index"
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  match "/sessions", to: "sessions#new", :as => "sessions"
  match "/users", to: "friendships#show", :as => "users"
  match "/feeds/:id", to: "feeds#show", :as => "feed_show"
  match "/feeds/:id/vote", to: "feeds#vote", :as => "vote"
  match "/comments/votecomment", to: "comments#votecomment", :as => "votecomment"
  match "/identities/new", to: "identities#new", :as => "new_identity"
  match "/identities/showplate/:id", to: "identities#showplate", :as => "showplate_identities"
  match "/identities/:id", to: "identities#show", :as => "user"
  match "/suggestions/1", to: "suggestions#show", :as => "suggestion"

  resources :identities
  resources :relationships
  resources :friendships
  resources :home 
  resources :settings
  resources :searches
  resources :platerelationships
  resources :userplaterelationships
  resources :plates
  resources :comments

end