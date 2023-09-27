Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :employees, only: %i[ index show ]
      resources :assignments, except: %i[ destroy edit new ]
    end
  end
end
