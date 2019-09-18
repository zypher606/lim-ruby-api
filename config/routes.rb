Rails.application.routes.draw do
  resources :webpages do
    resources :contents
  end
end
