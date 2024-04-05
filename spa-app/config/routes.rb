# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :donors, path: 'donors', controllers: { sessions: 'donors/sessions' }
  devise_for :orgs, path: 'orgs', controllers: { sessions: 'orgs/sessions' }
  devise_for :users, path: 'users', controllers: { sessions: 'users/sessions' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # DonorBox routes
  namespace :donorbox do
    post '/webhooks', to: 'webhooks#create'
  end

  # API routes
  namespace :api do
    namespace :v1 do
      resources :requests do
        collection do
          get 'animals'
        end
      end
      resources :orgs do
        collection do
          get 'summary'
          get 'donations'
          get 'donors'
          get 'templates'
          post 'upload_donors'
          post 'send_email'
          post 'update_campaign_request'
          post 'create_campaign_request'
        end
      end
      resources :campaigns do
        collection do
          get 'summary'
          get 'reviews'
        end
      end
      post 'emails/send', to: 'emails#send_email'
    end
  end

  # Regular routes
  resources :requests

  resources :update_campaign_requests
  resources :campaign_requests

  # Defines the root path route ("/")
  root 'requests#index'
end
