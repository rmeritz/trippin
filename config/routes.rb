Rails.application.routes.draw do
  resources :trips, only: [:new, :create, :show] do
    resources :point_creators, only: :create
  end
end
