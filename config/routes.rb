Rails.application.routes.draw do
  resources :users, only: [:show] do
    member do
      post :follow
      delete :unfollow
    end
  end

  resources :posts, only: [:index, :create] do
    collection do
      get :following
      get :replies
    end
  end
end
