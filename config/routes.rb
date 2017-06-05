Rails.application.routes.draw do
  root 'trips#new'
  resources :trips, only: [:new, :create, :show] do
    resources :point_creators, only: :create
  end
  resources :point_creator_job_statuses, only: [:show]
end
