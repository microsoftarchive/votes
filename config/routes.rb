Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :votes
      resource  :vote_counts
    end
  end
end
