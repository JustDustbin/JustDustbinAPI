Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :dustbins
      get '/dustbins/:id/update_status', to: 'dustbins#update_status', as: 'dustbin_update_status'
    end
  end
end
