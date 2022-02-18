Rails.application.routes.draw do
  resources :users, only: [:show] do
    member do
      post :follow
      delete :unfollow
    end
  end
end
