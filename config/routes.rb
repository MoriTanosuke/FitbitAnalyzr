Fitbit::Application.routes.draw do

  resources :custom_data
  controller :custom_data do
    get 'clear' => :clear
  end

  resources :foods
  controller :foods do
    get 'clear' => :clear
  end

  resources :welcomes
  resources :activities
  controller :activities do
    get 'clear' => :clear
  end

  resources :measurements
  controller :measurements do
    get 'clear' => :clear
  end

  resources :sleeps
  controller :sleeps do
    get 'clear' => :clear
  end

  resources :users
  resources :subscriptions

  resources :oauth_consumers do
    member do
      get :callback
      get :callback2
      match 'client/*endpoint' => 'oauth_consumers#client'
    end
  end

  get "admin" => "admin#index"
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  match '/register', :to => 'users#new'
  match '/delete', :to => 'users#destroy'
  match '/deauthorize', :to => 'users#deauthorize'
  match '/contact', :to => 'welcome#contact'
  match '/privacy', :to => 'welcome#privacy'
  match '/notify', :to => 'subscriptions#notify', :via => :post
  match '/logout', :to => 'sessions#destroy'

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
