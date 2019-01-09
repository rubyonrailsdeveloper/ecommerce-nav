Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :menu_items, except: :show do
      member do
        get :children
      end
    end
  end
end
