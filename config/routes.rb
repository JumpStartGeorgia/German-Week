GermanWeek::Application.routes.draw do

  root :to => 'german_week#index'

  devise_for :users
    
  match '/:locale' => 'german_week#index', via: :get

  scope "/:locale" do
    resources :locales
  end
  
  scope "/:locale" do
    resources :categories
  end
  
  scope "/:locale" do
    resources :sponsors
  end
  
  scope "/:locale" do
    resources :events do
    end
  end
  
  # create route to export events to ICS By ID
  match '/:locale/events/exportICS/event/:id', :to => 'events#exportICSById', :as => :events_exportICSById, :via => 'get'
  # create route to export events to ICS By Date
  match '/:locale/events/exportICS/day/:date', :to => 'events#exportICSByDate', :as => :events_exportICSByDate, :via => 'get'
  
  # create route to load events for a particular date
  match '/:locale/events/day/:date', :to => 'events#day', :as => :events_day, :via => 'get'
  
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

   
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
