Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks'}
  resources :users do
    resources :meals do

    end
  end

  resources :users do
    resources :workouts do

    end
  end

  get 'users/auth/spotify/callback', to: 'users#spotify'

# get 'new'
# post 'create'
# get 'edit'
# post 'update'
# get 'index'
# post 'destory'

  root 'landing#index'
end
